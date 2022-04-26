#
#  Makefile
#
################################################################################

create-namespace:
	@echo "---  namespaces  ---"
	kubectl create namespace postgres
	kubectl get namespace | grep postgres
	@echo ""

delete-namespace:
	@echo "---  namespaces  ---"
	kubectl delete namespace postgres
	kubectl get namespace
	@echo ""


################################################################################

create-network:
	@echo "---  networks  ---"
	kubectl create -f network.yaml
	kubectl get networkpolicy -A
	@echo ""

delete-network:
	@echo "---  networks  ---"
	kubectl delete -f network.yaml
	kubectl get networkpolicy -A
	@echo ""


################################################################################

create-service:
	@echo "---  services  ---"
	kubectl create -f service.yaml
	kubectl get services --namespace=postgres
	@echo ""

delete-service:
	@echo "---  services  ---"
	kubectl delete -f service.yaml
	kubectl get services --namespace=postgres
	@echo ""


################################################################################

create-statefulset:
	@echo "---  statefulsets  ---"
	kubectl create -f statefulset_test.yaml
	kubectl get statefulsets --namespace=postgres
	@echo ""

delete-statefulset:
	@echo "---  statefulsets  ---"
	kubectl delete -f statefulset_test.yaml
	kubectl get statefulsets --namespace=postgres
	@echo ""


################################################################################

create-all: create-namespace create-network create-service create-statefulset

delete-all: delete-statefulset delete-service delete-network delete-namespace

delete: delete-statefulset

create: create-statefulset

################################################################################

logs:
	kubectl logs -l app=postgres --all-containers=true --namespace=postgres

ps:
	kubectl get statefulset -A
	kubectl get pods --namespace=postgres
	kubectl describe statefulset --namespace postgres

exec:
	kubectl exec -it --namespace=postgres postgres-statefulset-0 -- /bin/bash

################################################################################
################################################################################
# 
# create-volume:
# 	@echo "---  volumes  ---"
# 	kubectl create -f volume.yaml
# 	kubectl get pv
# 	@echo ""
# 
# delete-volume:
# 	@echo "---  volumes  ---"
# 	kubectl delete persistentvolumeclaims postgres-volume-claim-postgres-statefulset-0 --namespace=postgres
# 	kubectl delete -f volume.yaml
# 	kubectl get pv
# 	@echo ""
# 
# 
################################################################################
# 
# create-volume-claim:
# 	kubectl create -f volume-claim.yaml
# 	kubectl get persistentvolumeclaims -A
#  
# delete-volume-claim:
# 	kubectl delete persistentvolumeclaims postgres-volume-claim-postgres-statefulset-0 --namespace=postgres
# 
# 
