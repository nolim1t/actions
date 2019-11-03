# Copyright 2019 nolim1t.co
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.

# You may obtain a copy of the License at

#      http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM alpine:3.10

LABEL "maintainer"="nolim1t <nolim1t@pm.me>"
LABEL "repository"="https://github.com/nolim1t/actions"
LABEL "version"="0.1.0"

LABEL "com.github.actions.name"="SCP TOR Deploy"
LABEL "com.github.actions.description"="Deploy a directory to SCP over TOR"
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="orange"

RUN mkdir -p /etc/init.d
COPY run /etc/init.d/tor

RUN apk update \
  && apk add openssh bash netcat-openbsd tor openrc

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
