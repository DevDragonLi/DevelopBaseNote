# private source cmd 
source = 'ssh:xxx'
pod repo push ZDPodSpecs --sources=${source} --swift-version=5.0 --skip-import-validation --skip-tests --use-json --allow-warnings --verbose
