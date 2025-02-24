namespace: Integrations.hcm202105_demo
flow:
  name: deploy_aos
  inputs:
    - target_host: demo.hcmx.local
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: FAILURE
          - SUCCESS: install_aos_application
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: FAILURE
          - SUCCESS: install_tomcat
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: FAILURE
          - SUCCESS: SUCCESS
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: FAILURE
          - SUCCESS: install_java
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_java:
        x: 326
        'y': 160
        navigate:
          a44449b2-3a96-01a8-4481-d502a9c870d6:
            targetId: 0d97dbce-d324-c4ce-8709-8db0ccf95192
            port: FAILURE
      install_aos_application:
        x: 686
        'y': 159
        navigate:
          a7d3dbba-6ba3-6248-87c0-8c29efe18312:
            targetId: 75dbba3d-3599-b839-9c35-d0fe5c277863
            port: SUCCESS
          9cf70ce4-e6f1-1b7c-7281-6d64310421bf:
            targetId: 0d97dbce-d324-c4ce-8709-8db0ccf95192
            port: FAILURE
      install_postgres:
        x: 102
        'y': 156
        navigate:
          31b9fe1b-e8e9-6586-1724-83358766881c:
            targetId: 0d97dbce-d324-c4ce-8709-8db0ccf95192
            port: FAILURE
      install_tomcat:
        x: 496
        'y': 149
        navigate:
          afa88156-12c3-6f98-bc2b-753487e9240d:
            targetId: 0d97dbce-d324-c4ce-8709-8db0ccf95192
            port: FAILURE
    results:
      SUCCESS:
        75dbba3d-3599-b839-9c35-d0fe5c277863:
          x: 896
          'y': 157
      FAILURE:
        0d97dbce-d324-c4ce-8709-8db0ccf95192:
          x: 286
          'y': 324
