# private source cmd 
source = 'ssh:xxx'
podRepo = 'podRepo'
pod repo push ${podRepo} --sources=${source} --swift-version=5.0 --skip-import-validation --skip-tests --use-json --allow-warnings --verbose
