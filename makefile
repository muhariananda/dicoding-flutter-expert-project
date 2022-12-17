PACKAGES := $(wildcard packages/*)
CORES := $(wildcard core/*)
FEATURES := $(wildcard features/*)

print:
	for feature in $(FEATURES); do \
		echo $${feature} ; \
	done
	for core in $(CORES); do \
		echo $${core} ; \
	done
	for package in $(PACKAGES); do \
		echo $${package} ; \
	done

get:
	flutter pub get
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Updating dependencies on $${feature}" ; \
		flutter pub get ; \
		cd ../../ ; \
	done
	for core in $(CORES); do \
		cd $${core} ; \
		echo "Updating dependencies on $${core}" ; \
		flutter pub get ; \
		cd ../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Updating dependencies on $${package}" ; \
		flutter pub get ; \
		cd ../../ ; \
	done

upgrade:
	flutter pub upgrade
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Upgrading dependencies on $${feature}" ; \
		flutter pub upgrade ; \
		cd ../../ ; \
	done
	for core in $(CORES); do \
		cd $${core} ; \
		echo "Upgrading dependencies on $${core}" ; \
		flutter pub upgrade ; \
		cd ../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Upgrading dependencies on $${package}" ; \
		flutter pub upgrade ; \
		cd ../../ ; \
	done

clean:
	flutter clean
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Cleaning dependencies on $${feature}" ; \
		flutter clean ; \
		cd ../../ ; \
	done
	for core in $(CORES); do \
		cd $${core} ; \
		echo "Cleaning dependencies on $${core}" ; \
		flutter clean ; \
		cd ../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Cleaning dependencies on $${package}" ; \
		flutter clean ; \
		cd ../../ ; \
	done

lint:
	flutter analyze

format:
	flutter format --set-exit-if-changed .

test:
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Testing dependencies on $${feature}" ; \
		flutter test ; \
		cd ../../ ; \
	done
	for core in $(CORES); do \
		cd $${core} ; \
		echo "Testing dependencies on $${core}" ; \
		flutter test ; \
		cd ../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Testing dependencies on $${package}" ; \
		flutter test ; \
		cd ../../ ; \
	done

test-coverage:
	for feature in $(FEATURES); do \
		cd $${feature} ; \
		echo "Testing dependencies on $${feature}" ; \
		flutter test --coverage ; \
		cd ../../ ; \
	done
	for core in $(CORES); do \
		cd $${core} ; \
		echo "Testing dependencies on $${core}" ; \
		flutter test --coverage ; \
		cd ../../ ; \
	done
	for package in $(PACKAGES); do \
		cd $${package} ; \
		echo "Testing dependencies on $${package}" ; \
		flutter test --coverage ; \
		cd ../../ ; \
	done