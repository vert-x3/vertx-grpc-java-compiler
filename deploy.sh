if [ -f ./x86_64-linux-gnu/protoc-gen-grpc-java.exe ] && [ -f ./i686-w64-mingw32/protoc-gen-grpc-java.exe ] && [ -f ./x86_64-w64-mingw32/protoc-gen-grpc-java.exe ] && [ -f ./x86_64-apple-darwin14/protoc-gen-grpc-java.exe ]; then
  PROJECT_VERSION=$(mvn org.apache.maven.plugins:maven-help-plugin:evaluate -Dexpression=project.version -B | grep -v '\[')
  
  if [[ "${PROJECT_VERSION}" =~ .*SNAPSHOT ]] && [[ "${TRAVIS_BRANCH}" = "master" ]] && [[ "${TRAVIS_PULL_REQUEST}" = "false" ]]; then
    mvn clean deploy -DskipTests -B;
  fi
fi
