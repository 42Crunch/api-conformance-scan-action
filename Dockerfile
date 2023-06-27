FROM python:3.12-rc-bookworm as build
COPY . /scanBuild
WORKDIR /scanBuild
RUN apt-get update && apt-get install -y
RUN pip install poetry
RUN poetry install --no-root
RUN poetry build

FROM python:3.12-rc-bookworm
COPY --from=build /scanBuild/dist/*.whl /scan/
RUN pip install scan/*.whl
# COPY ./action.sh /
# RUN ["chmod", "+x", "/action.sh"]
# ENTRYPOINT ["/action.sh"]