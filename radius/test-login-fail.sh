#!/bin/bash

docker exec -it my-radius /bin/bash -c "radtest tester wrong localhost:1812 1 bubu123"