set -e

poll_cowin_and_send_alert() {
  district_id="$1"
  chat_id="$2"
  echo "=== Searching slot availability for district id ${district_id} ==="
  rm -f ./*.json
  current_date=$(TZ=Asia/Kolkata date +"%d-%m-%Y")
  curl --retry 3 -fL "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=${district_id}&date=${current_date}" -H "${USER_AGENT_HEADER}" -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en,en-US;q=0.5' --compressed -H "${COWIN_AUTHORIZATION_TOKEN}" -H "Origin: ${ORGIN_URL}" -H 'Connection: keep-alive' -H "Referer: ${ORGIN_URL}" -H 'Sec-GPC: 1' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'TE: Trailers' | jq > ./cowin-centers.json
  jq -r '[.centers[] | select(.sessions[] | .min_age_limit == 18 and .available_capacity_dose1 > 0)]' ./cowin-centers.json | jq -r '.[] | "Dose 1 of \([.sessions[].vaccine] | unique | join(",")) available at \(.name), \(.block_name), \(.pincode)"' | uniq > dose-1-result.txt
  result=$(cat dose-1-result.txt)
  if [ -z "$result" ]
  then
    echo "Not sending notification to telegram as there is no result"
  else
    echo "Sending alert..."
    echo $result
  fi
  echo "Sleeping for 1 second to prevent telegram rate limiting"
  sleep 1
}

max_attempts=1000
sleep_time=30
attempt_counter=0
while [ ${attempt_counter} -le ${max_attempts} ]
do
  poll_cowin_and_send_alert 540 -1001446207884
  echo "Beginning sleep for ${sleep_time} seconds"
  sleep ${sleep_time}
  attempt_counter=$((attempt_counter+1))
done