const json1 = require("./timeline1.json");
const json2 = require("./timeline2.json");
const json3 = require("./timeline3.json");
const puppeteer = require('puppeteer');
const sleep = msec => new Promise(resolve => setTimeout(resolve, msec));
const savedir = `public/0/img`;
process.setMaxListeners(Infinity);

async function capture(id_str, savefile, media_url) {
	let url = `https://twitter.com/i/web/status/${id_str}`;

	console.log(url, savefile);
	const browser = await puppeteer.launch({
		args: ['--lang=ja', '--no-sandbox', '--disable-setuid-sandbox']
	});
	const page = await browser.newPage();

	page.on('console', async (msg) => {
		const msgArgs = msg.args();
		for (let i = 0; i < msgArgs.length; ++i) {
			console.log(await msgArgs[i].jsonValue());
		}
	});

        const _cookie = {
	    url: "https://twitter.com",
            name: "auth_token",
            value: "****************************************"
        };
        await page.setCookie(_cookie);
	await page.setExtraHTTPHeaders({
		'Accept-Language': 'ja',
		'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36'
	});
	await page.setViewport({
		width: 640,
		height: 1640,
	});
	await page.goto(url, {
		waitUntil: ["networkidle2"],
		//timeout: 10000
	});

	// for sensitive
	const found_sensitive = (await page.content()).match(/センシティブ/gi)
	// console.log("found_sensitive?: ", found_sensitive);
	if (found_sensitive) {
		const xpath = '/html/body/div/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/section/div/div/div[5]/div/div/article/div/div/div/div[2]/div[2]/div[2]/div[2]/div/div/div/div[2]/div/div/div/div/div/div/div[2]/div/div[2]/div/div/span/span';
		const view_el = await page.$x(xpath);
		await sleep(500);
		await view_el[0].click();
		await sleep(500);
	}

	
	let videoElement = await page.$('[data-testid="videoComponent"]');
	if (videoElement && media_url) {
		videoElement.evaluate((element, media_url) => { 
			element.innerHTML = '<img src="' + media_url + '" style="position:absolute;z-index:1;width:100%;height:100%;">';
		}, media_url);
	}

	const el = await page.$('a[href$="' + id_str + '"]');
	const article = (await el.$x('../../../../../../../..'))[0];
	await sleep(1000);

	await article.screenshot({
		path: savefile
	});
	await browser.close();
}

(async () => {
	await main();
	//await sample();
	console.log(`exit create snapshot`);
	process.exit(0);
})();

async function sample() {
	let id_str = "1679687172428009472";
	let url = `https://twitter.com/i/web/status/${id_str}`;
	let savefile = `public/1/img/${id_str}.png`;
	let media_url = 'https://pbs.twimg.com/media/F09yJ3PacAAe4H1.jpg';
	await capture(id_str, savefile, media_url);
}

async function main() {
	let tweet_data = [];
	let entries1 = json1.data.search_by_raw_query.search_timeline.timeline.instructions[0].entries;
	let entries2 = json2.data.search_by_raw_query.search_timeline.timeline.instructions[0].entries;
	let entries3 = json3.data.search_by_raw_query.search_timeline.timeline.instructions[0].entries;
	for (let i = 0; i < entries1.length; i++) {
	try {
		entry = entries1[i];
		mediaUrl = null;
                if ( entry.entryId.indexOf('tweet-') == 0 && entry.content.itemContent.tweet_results.result.__typename == "Tweet") {
			strId = entry.content.itemContent.tweet_results.result.rest_id;
			console.log(`Parse JSON[${i}] strId: ` + strId);
			if (entry.content.itemContent.tweet_results.result.legacy.entities.media) {
				mediaUrl = entry.content.itemContent.tweet_results.result.legacy.entities.media[0].media_url_https;
			}
			tweet_data.push({strId:strId, mediaUrl:mediaUrl});
		}
	} catch (e) {
		console.log(e);
	}
	}

        for (let i = 0; i < entries2.length; i++) {
	try {
                entry = entries2[i];
		mediaUrl = null;
                if ( entry.entryId.indexOf('tweet-') == 0 && entry.content.itemContent.tweet_results.result.__typename == "Tweet") {
                        strId = entry.content.itemContent.tweet_results.result.rest_id;
			console.log(`Parse JSON[${i}] strId: ` + strId);
			if (entry.content.itemContent.tweet_results.result.legacy.entities.media) {
				mediaUrl = entry.content.itemContent.tweet_results.result.legacy.entities.media[0].media_url_https;
			}
			tweet_data.push({strId:strId, mediaUrl:mediaUrl});
                }
	} catch (e) {
		console.log(e);
	}
        }

        for (let i = 0; i < entries3.length; i++) {
	try {
                entry = entries3[i];
		mediaUrl = null;
                if ( entry.entryId.indexOf('tweet-') == 0 && entry.content.itemContent.tweet_results.result.__typename == "Tweet") {
                        strId = entry.content.itemContent.tweet_results.result.rest_id;
			console.log(`Parse JSON[${i}] strId: ` + strId);
			if (entry.content.itemContent.tweet_results.result.legacy.entities.media) {
				mediaUrl = entry.content.itemContent.tweet_results.result.legacy.entities.media[0].media_url_https;
			}
			tweet_data.push({strId:strId, mediaUrl:mediaUrl});
                }
	} catch (e) {
		console.log(e);
	}
        }
	let filecount = 0;
	for (let i = 0; i < tweet_data.length; i++) {
		let tweet = tweet_data[i];
		let url = `https://twitter.com/i/web/status/${tweet.strId}`;
		console.log(url);
		filecount++;
		console.log(`  filecount: ${filecount}`);
		let savefile = `${savedir}/${filecount}.png`;

		let result = 0;
		try {
			console.log(`Capture trying...`);
			await capture(tweet.strId, savefile, tweet.mediaUrl);
		} catch (e) {
			console.log(`Error: ${e.message}`);
			result = 1;
		}

		// retry
		if (result != 0) {
			result = 0;
			try {
				console.log(`Retrying(1)...`);
				await capture(tweet.strId, savefile, tweet.mediaUrl);
			} catch (e) {
				console.log(`Error: ${e.message}`);
				result = 1;
			}
		}

		// retry
		if (result != 0) {
			result = 0;
			try {
				console.log(`Retrying(2)...`);
				await capture(tweet.strId, savefile, tweet.mediaUrl);
			} catch (e) {
				console.log(`Error: ${e.message}`);
				result = 1;
			}
		}

		await sleep(30000);
	}
}

