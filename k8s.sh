#!/bin/bash

PROMPT="🤔"
DONE="🏆"
INFO="ℹ️"

menu_items=("🟢 Full Deployment", "🔵 Run Server", "EXIT🚪")

# GLOBAL VARIABLES
image_name=nil
deployment_name=nil
hub_username=nil
service_name=nil
replicas=0


##
# MENU
##

menu() {
    echo -e "\n${INFO} Setting up Kubernetes Clusters"

    echo -ne "
    ${INFO} Fireball Setup Menu
    1. Run Full Deployment (setup minikube to deployment) 🟢
    2. Run Server 🔵
    3. Run Deployment 🚀
    4. Scale Deployment 🔢
    5. Build and Push Docker Image 🐳
    6. Start Minikube 🚀
    7. Show Logs 📜
    8. Show Configs 📁
    0. Exit 🚪
    \nChoose an option:  ➕ " 

    read a
    case $a in
        1) full_deployment ; menu ;;
        2) run_server ; menu ;;
        3) deploy ; menu ;;
        4) scale_deployment ; menu ;;
        5) build_docker ; menu ;;
        6) start_minikube ; menu ;;
        7) show_logs ; menu ;;
        8) show_globals ; menu ;;
        0) exit 0 ;;
        *) echo -e "${RED}Wrong option.${STD}" && sleep 2
    esac

}

build_docker() {
    echo -e "\n${INFO} Comming soon"
}

full_deployment(){
    echo -e "\n${INFO} Starting Full Deployment"
    start_minikube
    build_docker
    deploy 

    echo -e "\n${DONE} Kubernetes Cluster Setup Complete"
}



##
# HELPER FUNCTIONS
##
start_minikube(){
    # start minikube
    echo -e "\n${PROMPT} Do you want to start minikube? (y/n)"
    read start_minikube
    if [ $start_minikube == "y" ];
    then
        echo -e "\n${PROMPT} Choose the driver. \n \t ${INFO}(d=docker, q=qemu)"
        read driver
        if [ $driver == "d" ];
        then
            echo -e "\n${INFO} Starting minikube with docker driver"
            minikube start
        elif [ $driver == "q" ];
        then
            echo -e "\n${INFO} Starting minikube with qemu driver"
            minikube start --driver=qemu
        fi
        echo -e "\n${INFO} Minikube started"
    fi
}

build_docker(){
    # build docker
    echo -e "\n${INFO} enter the docker image name: (imagename)"
    read input
    
    # set image name
    image_name=$input

    docker build -t $image_name .


    # push to docker hub
    echo -e "\n${INFO} Do you want to push the image to docker hub? (y/n)"
    read push_image

    if [ $push_image == "y" ];
    then
        echo -e "\n${INFO} enter the docker hub username"
        read input

        # set hub username
        hub_username=$input

        # docker tag $image_name $hub_username/$image_name
        docker push $hub_username/$image_name
    fi
}


deploy() {

    if [ $image_name == "nil" ];
    then
        echo -e "\n${INFO} enter the docker image name: (imagename)"
        read input
        
        # set image name
        image_name=$input
    fi

    # create deployment
    echo -e "\n${INFO} enter the deployment name"
    read input

    # set deployment name
    deployment_name=$input

    kubectl create deployment $deployment_name --image=$image_name


    kubectl expose deployment $deployment_name --type=NodePort --port=8010 

    

}

scale_deployment() {
    # Scale Deployments
    echo -e "\n${PROMPT} Are you sure you want to scale the deployment? (y/n)"
    read input

    # set scale deployment
    scale_deployment=$input

    if [ $scale_deployment == "y" ];
    then
        check_deployment
        # echo -e "\n${PROMPT} Enter the deployment name"
        # read deployment_name
        echo -e "\n${PROMPT} Enter the number of replicas"
        read replicas
        kubectl scale deployment $deployment_name --replicas=$replicas
    fi
}

show_globals(){
    # Print the table header
    print_separator
    print_row "Configuration Key" "Value"
    print_separator

    # Print the configuration rows
    print_row "Image Name" "$image_name"
    print_row "Deployment Name" "$deployment_name"
    print_row "Hub Username" "$hub_username"
    # print_row "Service Name" "$service_name"
    print_row "Replicas" "$replicas"

    # Print the bottom border of the table
    print_separator
    
}

check_deployment() {
    
    if [ $deployment_name == "nil" ];
    then
        # list deployments
        echo -e "\n${INFO} Do you want to list deployments? (y/n)"
        read input
        if [ $input == "y" ];
        then
            echo -e "\n${INFO} Listing deployments"
            kubectl get deployments
        fi
        
        echo -e "\n${INFO} enter the deployment name"
        read input

        # set deployment name
        deployment_name=$input
    fi
}

show_logs() {
    # show logs
    # show pods and services
    echo -e "\n${INFO} Do you want to show pods, services and deploymets? (y/n)"
    read input
    if [ $input == "y" ];
    then
        echo -e "\n${INFO} Showing logs."

        echo -e "\n${INFO} Pods"
        kubectl get pods

        echo -e "\n${INFO} Deployments"
        kubectl get deployments

        echo -e "\n${INFO} Services"
        kubectl get services

    fi
}


run_server() {
    check_deployment

    # Run Server
    echo -e "\n${INFO} Do you want to run the server? (y/n)"
    read input
    if [ $input == "y" ];
    then
        echo -e "\n${INFO} Running Server"
        minikube service $deployment_name
    fi
}

print_row() {
    # Function to print a row   
    printf "| %-20s | %-30s |\n" "$1" "$2"
}

print_separator() {
    # Function to print a separator line
    printf "+----------------------+--------------------------------+\n"
}

##
# CALL MENU
##
menu

