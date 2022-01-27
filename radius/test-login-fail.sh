#!/bin/bash

docker exec -it freeradius /bin/bash -c "radtest tester wrong localhost:1812 1 bubu123"