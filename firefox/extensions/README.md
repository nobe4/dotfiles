# Firefox extensions

## Temporary Install

1. Open `about:debugging#/runtime/this-firefox`.
2. Select **Load Temporary Add-on**.
3. Select the extension's `manifest.json`, such as
   `copy-url/manifest.json`.

Firefox temporary add-ons when the browser exits.

## Disable the default shortuct

1. Open `about:keyboard`
2. Scroll to the corresponding
3. reset/disable

## Update a temporary add-on

After changing files, return to `about:debugging#/runtime/this-firefox` and
select **Reload** beside the extension.

## Install permanently

Standard Firefox requires a Mozilla-signed `.xpi`.

1. Build the extension from this directory:

   ```sh
   npx web-ext build --source-dir copy-url
   ```

2. Open the [Firefox Add-on Developer Hub](https://addons.mozilla.org/developers/).
3. Submit the archive from `web-ext-artifacts/` as **On your own** or
   **Unlisted**.
4. Download the signed `.xpi` after validation.
5. Open `about:addons`, select the gear menu, then select
   **Install Add-on From File**.

The signed add-on remains installed after Firefox restarts.

## Update a permanent add-on

1. Increase `version` in the extension's `manifest.json`.
2. Build another archive.
3. Submit it as a new version of the same add-on.
4. Install the newly signed `.xpi`.

## Shortcuts

Open `about:addons`, select the gear menu, then select **Manage Extension
Shortcuts** to inspect or change extension shortcuts.

To stop websites from overriding extension shortcuts:

1. Open `about:config`.
2. Search for `permissions.default.shortcuts`.
3. Set its numeric value to `2`.

This browser-wide setting blocks websites from overriding Firefox shortcuts. It
avoids granting the extension access to website data.

## References

- [Temporary installation](https://extensionworkshop.com/documentation/develop/temporary-installation-in-firefox/)
- [Signing and distribution](https://extensionworkshop.com/documentation/publish/signing-and-distribution-overview/)
- [permissions `2`](https://support.mozilla.org/en-US/questions/1241294)
