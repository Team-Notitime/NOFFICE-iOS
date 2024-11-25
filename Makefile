TUIST = tuist
SWIFTLINT = swiftlint
FASTLANE = fastlane

all: lint generate

full-generate:
	$(TUIST) install
	TUIST_ROOT_DIR=${PWD} $(TUIST) generate
	$(SWIFTLINT) autocorrect --fix
	$(FASTLANE) match
	
generate:
	TUIST_ROOT_DIR=${PWD} $(TUIST) generate

lint:
	$(SWIFTLINT)

clean:
	rm -rf DerivedData

format:
	$(SWIFTLINT) autocorrect --fix

help:
	@echo "사용 가능한 명령어:"
	@echo "  make all           - 린트 및 dev 빌드 수행"
	@echo "  make full-generate - install, generate, lint, match 실행"
	@echo "  make generate      - tuist generate 수행"
	@echo "  make lint          - 코드 린트"
	@echo "  make clean         - 빌드 파일 삭제"
	@echo "  make format        - 코드 자동 포맷팅"
	@echo "  make help          - 사용 가능한 명령어 목록 출력"
