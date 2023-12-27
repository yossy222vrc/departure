#!/usr/bin/bash

echo "[start] at `date '+%Y-%m-%d %H:%M:%S'`. pid:$$"


echo '[killall]'
#killall -9 node
#killall -9 chrome
#killall -9 mogrify
#killall -9 pngquant


echo "[mkdir] create 'public/0'."
mkdir -p public/0/img


echo "[cp] copy index.html to 'public/0'."
cp -rf index.html public/0/


echo "[curl] get tweet from graphql api. save to 'timeline[123].json'."
curl 'https://twitter.com/i/api/graphql/TTaY6D-2OiFZ_aoj-EFDMw/SearchTimeline?variables=%7B%22rawQuery%22%3A%22%23VRChat_world%E7%B4%B9%E4%BB%8B%22%2C%22count%22%3A20%2C%22querySource%22%3A%22typeahead_click%22%2C%22product%22%3A%22Latest%22%7D&features=%7B%22rweb_lists_timeline_redesign_enabled%22%3Atrue%2C%22responsive_web_graphql_exclude_directive_enabled%22%3Atrue%2C%22verified_phone_label_enabled%22%3Afalse%2C%22creator_subscriptions_tweet_preview_api_enabled%22%3Atrue%2C%22responsive_web_graphql_timeline_navigation_enabled%22%3Atrue%2C%22responsive_web_graphql_skip_user_profile_image_extensions_enabled%22%3Afalse%2C%22tweetypie_unmention_optimization_enabled%22%3Atrue%2C%22responsive_web_edit_tweet_api_enabled%22%3Atrue%2C%22graphql_is_translatable_rweb_tweet_is_translatable_enabled%22%3Atrue%2C%22view_counts_everywhere_api_enabled%22%3Atrue%2C%22longform_notetweets_consumption_enabled%22%3Atrue%2C%22responsive_web_twitter_article_tweet_consumption_enabled%22%3Afalse%2C%22tweet_awards_web_tipping_enabled%22%3Afalse%2C%22freedom_of_speech_not_reach_fetch_enabled%22%3Atrue%2C%22standardized_nudges_misinfo%22%3Atrue%2C%22tweet_with_visibility_results_prefer_gql_limited_actions_policy_enabled%22%3Atrue%2C%22longform_notetweets_rich_text_read_enabled%22%3Atrue%2C%22longform_notetweets_inline_media_enabled%22%3Atrue%2C%22responsive_web_media_download_video_enabled%22%3Afalse%2C%22responsive_web_enhance_cards_enabled%22%3Afalse%7D&fieldToggles=%7B%22withArticleRichContentState%22%3Afalse%7D' --compressed -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/114.0' -H 'Accept: */*' -H 'Accept-Language: ja,en-US;q=0.7,en;q=0.3' -H 'Accept-Encoding: gzip, deflate, br' -H 'content-type: application/json' -H 'authorization: Bearer ********************************************************************************************************' -H 'x-twitter-auth-type: OAuth2Session' -H 'x-csrf-token: ****************************************************************************************************************************************************************' -H 'x-twitter-client-language: ja' -H 'x-twitter-active-user: yes' -H 'DNT: 1' -H 'Connection: keep-alive' -H 'Referer: https://twitter.com/search?q=%23VRChat_world%E7%B4%B9%E4%BB%8B&src=typeahead_click&f=live' -H 'Cookie: auth_token=****************************************' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: same-origin' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'TE: trailers' > timeline1.json

CURSOR1=`cat timeline1.json | jq '.data.search_by_raw_query.search_timeline.timeline.instructions[0].entries[] | select(.entryId == "cursor-bottom-0")' | jq -r '.content.value'`

curl 'https://twitter.com/i/api/graphql/nK1dw4oV3k4w5TdtcAdSww/SearchTimeline?variables=%7B%22rawQuery%22%3A%22%23VRChat_world%E7%B4%B9%E4%BB%8B%22%2C%22count%22%3A20%2C%22cursor%22%3A%22'${CURSOR1}'%22%2C%22querySource%22%3A%22typeahead_click%22%2C%22product%22%3A%22Latest%22%7D&features=%7B%22rweb_lists_timeline_redesign_enabled%22%3Afalse%2C%22responsive_web_graphql_exclude_directive_enabled%22%3Atrue%2C%22verified_phone_label_enabled%22%3Afalse%2C%22creator_subscriptions_tweet_preview_api_enabled%22%3Atrue%2C%22responsive_web_graphql_timeline_navigation_enabled%22%3Atrue%2C%22responsive_web_graphql_skip_user_profile_image_extensions_enabled%22%3Afalse%2C%22tweetypie_unmention_optimization_enabled%22%3Atrue%2C%22responsive_web_edit_tweet_api_enabled%22%3Atrue%2C%22graphql_is_translatable_rweb_tweet_is_translatable_enabled%22%3Atrue%2C%22view_counts_everywhere_api_enabled%22%3Atrue%2C%22longform_notetweets_consumption_enabled%22%3Atrue%2C%22responsive_web_twitter_article_tweet_consumption_enabled%22%3Afalse%2C%22tweet_awards_web_tipping_enabled%22%3Afalse%2C%22freedom_of_speech_not_reach_fetch_enabled%22%3Atrue%2C%22standardized_nudges_misinfo%22%3Atrue%2C%22tweet_with_visibility_results_prefer_gql_limited_actions_policy_enabled%22%3Atrue%2C%22longform_notetweets_rich_text_read_enabled%22%3Atrue%2C%22longform_notetweets_inline_media_enabled%22%3Atrue%2C%22responsive_web_media_download_video_enabled%22%3Afalse%2C%22responsive_web_enhance_cards_enabled%22%3Afalse%7D&fieldToggles=%7B%22withArticleRichContentState%22%3Afalse%7D' --compressed -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/114.0' -H 'Accept: */*' -H 'Accept-Language: ja,en-US;q=0.7,en;q=0.3' -H 'Accept-Encoding: gzip, deflate, br' -H 'Referer: https://twitter.com/search?q=%23VRChat_world%E7%B4%B9%E4%BB%8B&src=typeahead_click&f=live' -H 'content-type: application/json' -H 'x-client-uuid: 3d17f707-5596-4bb4-9ab4-827c9147caca' -H 'x-twitter-auth-type: OAuth2Session' -H 'x-csrf-token: ****************************************************************************************************************************************************************' -H 'x-twitter-client-language: ja' -H 'x-twitter-active-user: yes' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: same-origin' -H 'authorization: Bearer ********************************************************************************************************' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'TE: trailers' > timeline2.json

CURSOR2=`cat timeline2.json | jq '.data.search_by_raw_query.search_timeline.timeline.instructions[2].entry.content.value' | jq -r .`

curl 'https://twitter.com/i/api/graphql/nK1dw4oV3k4w5TdtcAdSww/SearchTimeline?variables=%7B%22rawQuery%22%3A%22%23VRChat_world%E7%B4%B9%E4%BB%8B%22%2C%22count%22%3A20%2C%22cursor%22%3A%22'${CURSOR2}'%22%2C%22querySource%22%3A%22typeahead_click%22%2C%22product%22%3A%22Latest%22%7D&features=%7B%22rweb_lists_timeline_redesign_enabled%22%3Afalse%2C%22responsive_web_graphql_exclude_directive_enabled%22%3Atrue%2C%22verified_phone_label_enabled%22%3Afalse%2C%22creator_subscriptions_tweet_preview_api_enabled%22%3Atrue%2C%22responsive_web_graphql_timeline_navigation_enabled%22%3Atrue%2C%22responsive_web_graphql_skip_user_profile_image_extensions_enabled%22%3Afalse%2C%22tweetypie_unmention_optimization_enabled%22%3Atrue%2C%22responsive_web_edit_tweet_api_enabled%22%3Atrue%2C%22graphql_is_translatable_rweb_tweet_is_translatable_enabled%22%3Atrue%2C%22view_counts_everywhere_api_enabled%22%3Atrue%2C%22longform_notetweets_consumption_enabled%22%3Atrue%2C%22responsive_web_twitter_article_tweet_consumption_enabled%22%3Afalse%2C%22tweet_awards_web_tipping_enabled%22%3Afalse%2C%22freedom_of_speech_not_reach_fetch_enabled%22%3Atrue%2C%22standardized_nudges_misinfo%22%3Atrue%2C%22tweet_with_visibility_results_prefer_gql_limited_actions_policy_enabled%22%3Atrue%2C%22longform_notetweets_rich_text_read_enabled%22%3Atrue%2C%22longform_notetweets_inline_media_enabled%22%3Atrue%2C%22responsive_web_media_download_video_enabled%22%3Afalse%2C%22responsive_web_enhance_cards_enabled%22%3Afalse%7D&fieldToggles=%7B%22withArticleRichContentState%22%3Afalse%7D' --compressed -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/114.0' -H 'Accept: */*' -H 'Accept-Language: ja,en-US;q=0.7,en;q=0.3' -H 'Accept-Encoding: gzip, deflate, br' -H 'Referer: https://twitter.com/search?q=%23VRChat_world%E7%B4%B9%E4%BB%8B&src=typeahead_click&f=live' -H 'content-type: application/json' -H 'x-client-uuid: 3d17f707-5596-4bb4-9ab4-827c9147caca' -H 'x-twitter-auth-type: OAuth2Session' -H 'x-csrf-token: ****************************************************************************************************************************************************************' -H 'x-twitter-client-language: ja' -H 'x-twitter-active-user: yes' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: same-origin' -H 'authorization: Bearer ********************************************************************************************************' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'TE: trailers' > timeline3.json


echo "[node] create snapshot to 'public/0/img'."
node create_snapshot4.js


echo "[mogrify] mogrify images to 640x1280 in 'public/0/img'"
mogrify -gravity center -background white -extent 640x1280 public/0/img/*.png


echo "[pngquant] optimize images in 'public/0/img'"
pngquant --ext .png --force public/0/img/*.png


MAX=250
for i in $(seq 1 $MAX); do
	from=$(($MAX - $i + 1))
	to=$(($from + 1))
	echo "[mv] move 'public/${from}' -> 'public/${to}'."
	mv public/${from} public/${to}
done


from=0
to=1
echo "[mv] move 'public/${from}' -> 'public/${to}'."
mv public/${from} public/${to}


echo "[rm] remove 'public/$(($MAX + 1))'."
rm -rf public/$(($MAX + 1))


echo "[rm] remove '/tmp/puppeteer_dev_chrome_profile*'."
rm -rf /tmp/puppeteer_dev_chrome_profile*
echo "[rm] remove '/tmp/.org.chromium.Chromium*'."
rm -rf /tmp/.org.chromium.Chromium*


echo "[end] at `date '+%Y-%m-%d %H:%M:%S'`. pid:$$"

