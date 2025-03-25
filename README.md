# sveltekit220
A minimal reproduction of an issue introduced in sveltekit 2.20

## Instructions to Reproduce the Issue

The following has already been configured in current repo:
1. Dependencies

    - Ensure `@sveltejs/kit` is at a version later than `2.19.2`. It can be `2.20.0`, `2.20.1` or `2.20.2`.
    
    - Ensure `vite-plugin-top-level-await` is a dependency and is correctly setup in `vite.config.ts`.

2. Hooks

    - You must have a minial configuration of `hooks.server.ts`

3. Emulate a Production Environment
   
   Run the following command. It will compile the sveltekit app and run a minimum production server.
   
   ```sh
   make prod
   ```
4. Expected Error

    The production server will end up with the following error:
    ```
    file:///build/handler.js:1174
    const server = new Server(manifest);
                ^
    TypeError: Server is not a constructor
        at file:///build/handler.js:1174:16
        at ModuleJob.run (node:internal/modules/esm/module_job:271:25)
        at async onImport.tracePromise.__proto__ (node:internal/modules/esm/loader:578:26)
        at async asyncRunEntryPointWithESMLoader (node:internal/modules/run_main:116:5)
    ```

## Experiments

### No Issue in Development Environment

The following command produced a development server. It has no issues.

```sh
make dev
```

### No Issue with SvelteKit `2.19.2`

Only modify `@sveltejs/kit` in `app/package.json` from `2.20.2` to `2.19.2`. Keep everything else unmodified.
Rerun `make prod`. No issue.

### No Issue After Removing `vite-plugin-top-level-await`

Only remove `vite-plugin-top-level-await` from `app/package.json` and `app/vite.config.ts`. Keep everything else unmodified.
Rerun `make prod`. No issue.

### No Issue After Deleting `hooks.server.ts`

Only delete file `app/src/hooks.server.ts`. Keep everything else unmodified.
Rerun `make prod`. No issue.

## Conclusion

When `vite-plugin-top-level-await` is used and `hooks.server.ts` exists, SvelteKit `2.20.0` introduced an issue to NodeJS runtime.

## Workaround

1. If `vite-plugin-top-level-await` and `hooks.server.ts` are absolutely required, use SvelteKit `2.19.2` instead.
2. If only need to support new browsers, `vite-plugin-top-level-await` can then be avoided by setting `build.target` as `esnext` in `vite.config.ts`.
