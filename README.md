# ngrok

Run this container:

    docker run \
    --name ngrok \
    --mount type=bind,source=/etc/ngrok,target=/etc/ngrok \
    --network host \
    --detach \
    --restart always \
    magicarena\ngrok
