async function copySelectedTabUrls() {
  const tabs = await browser.tabs.query({
    currentWindow: true,
    highlighted: true,
  });
  const urls = tabs
    .sort((left, right) => left.index - right.index)
    .map((tab) => tab.url)
    .filter(Boolean);

  if (!urls.length) {
    return;
  }

  await navigator.clipboard.writeText(urls.join("\n"));

  const notificationId = await browser.notifications.create({
    type: "basic",
    title: "URLs",
    message: urls.join("\n"),
  });

  setTimeout(() => browser.notifications.clear(notificationId), 5000);
}

browser.commands.onCommand.addListener((command) => {
  if (command === "copy-tab-urls") {
    copySelectedTabUrls().catch((error) => console.error(error));
  }
});
