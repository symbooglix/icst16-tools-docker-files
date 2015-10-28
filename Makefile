NAMESPACE=symbooglix
TAG=:icst16

all:: corral boogie gpuverify boogaloo

.PHONY: mono_z3_base boogie corral gpuverify boogaloo user_base

boogaloo: boogaloo/Dockerfile boogaloo/builtin_attribute_boogaloo.patch boogaloo/c11cc364a7f60baa36bfb77a39733a7a3957a692.patch boogaloo/hack_mtl_version.patch
	docker build -t $(NAMESPACE)/$@$(TAG) --file $< boogaloo/

gpuverify: gpuverify/Dockerfile gpuverify/gvfindtools.py mono_z3_base
	docker build -t $(NAMESPACE)/$@$(TAG) --file $< gpuverify/

corral: corral/Dockerfile mono_z3_base
	docker build -t $(NAMESPACE)/$@$(TAG) --file $< corral/

boogie: boogie/Dockerfile mono_z3_base
	docker build -t $(NAMESPACE)/$@$(TAG) --file $< boogie/

mono_z3_base: mono_z3_base/Dockerfile user_base
	docker build -t $(NAMESPACE)/$@$(TAG) --file $< mono_z3_base/

user_base: user_base/Dockerfile
	docker build -t $(NAMESPACE)/$@$(TAG) --file $< user_base/
