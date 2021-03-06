template={
    "AWSTemplateFormatVersion": "2010-09-09",
    "Description": "AWS CloudFormation template to create a new VPC or use an existing VPC for ECS deployment in Create Cluster Wizard. Requires exactly 1 Instance Types for a Spot Request.\n",
    "Parameters": {
        "EcsClusterName": {
            "Type": "String",
            "Description": "Specifies the ECS Cluster Name with which the resources would be associated\n",
            "Default": "default"
        },
        "KvsStream":{
            "Type":"String",
            "Description":"Kinesis Video stream for Consumer app\n"
        },
        "SqsQueue":{
            "Type":"String",
            "Description":"SQS Queue for video fragments\n"
        },
        "EcsAmiId": {
            "Type": "String",
            "Description": "Specifies the AMI ID for your container instances."
        },
        "EcsInstanceType": {
            "Type": "CommaDelimitedList",
            "Description": "Specifies the EC2 instance type for your container instances. Defaults to m4.large\n",
            "Default": "m4.large",
            "ConstraintDescription": "must be a valid EC2 instance type."
        },
        "KeyName": {
            "Type": "String",
            "Description": "Optional - Specifies the name of an existing Amazon EC2 key pair to enable SSH access to the EC2 instances in your cluster.\n",
            "Default": ""
        },
        "VpcId": {
            "Type": "String",
            "Description": "Optional - Specifies the ID of an existing VPC in which to launch your container instances. If you specify a VPC ID, you must specify a list of existing subnets in that VPC. If you do not specify a VPC ID, a new VPC is created with atleast 1 subnet.\n",
            "Default": "",
            "ConstraintDescription": "VPC Id must begin with 'vpc-' or leave blank to have a new VPC created\n"
        },
        "SubnetIds": {
            "Type": "CommaDelimitedList",
            "Description": "Optional - Specifies the Comma separated list of existing VPC Subnet Ids where ECS instances will run\n",
            "Default": ""
        },
        "SecurityGroupId": {
            "Type": "String",
            "Description": "Optional - Specifies the Security Group Id of an existing Security Group. Leave blank to have a new Security Group created\n",
            "Default": ""
        },
        "VpcCidr": {
            "Type": "String",
            "Description": "Optional - Specifies the CIDR Block of VPC",
            "Default": ""
        },
        "SubnetCidr1": {
            "Type": "String",
            "Description": "Specifies the CIDR Block of Subnet 1",
            "Default": ""
        },
        "SubnetCidr2": {
            "Type": "String",
            "Description": "Specifies the CIDR Block of Subnet 2",
            "Default": ""
        },
        "SubnetCidr3": {
            "Type": "String",
            "Description": "Specifies the CIDR Block of Subnet 3",
            "Default": ""
        },
        "AsgMaxSize": {
            "Type": "Number",
            "Description": "Specifies the number of instances to launch and register to the cluster. Defaults to 1.\n",
            "Default": "1"
        },
        "IamRoleInstanceProfile": {
            "Type": "String",
            "Description": "Specifies the Name or the Amazon Resource Name (ARN) of the instance profile associated with the IAM role for the instance\n"
        },
        "SecurityIngressFromPort": {
            "Type": "Number",
            "Description": "Optional - Specifies the Start of Security Group port to open on ECS instances - defaults to port 0\n",
            "Default": "0"
        },
        "SecurityIngressToPort": {
            "Type": "Number",
            "Description": "Optional - Specifies the End of Security Group port to open on ECS instances - defaults to port 65535\n",
            "Default": "65535"
        },
        "SecurityIngressCidrIp": {
            "Type": "String",
            "Description": "Optional - Specifies the CIDR/IP range for Security Ports - defaults to 0.0.0.0/0\n",
            "Default": "0.0.0.0/0"
        },
        "EcsEndpoint": {
            "Type": "String",
            "Description": "Optional - Specifies the ECS Endpoint for the ECS Agent to connect to\n",
            "Default": ""
        },
        "VpcAvailabilityZones": {
            "Type": "CommaDelimitedList",
            "Description": "Specifies a comma-separated list of 3 VPC Availability Zones for the creation of new subnets. These zones must have the available status.\n",
            "Default": ""
        },
        "RootEbsVolumeSize": {
            "Type": "Number",
            "Description": "Optional - Specifies the Size in GBs of the root EBS volume\n",
            "Default": 30
        },
        "EbsVolumeSize": {
            "Type": "Number",
            "Description": "Optional - Specifies the Size in GBs of the data storage EBS volume used by the Docker in the AL1 ECS-optimized AMI\n",
            "Default": 22
        },
        "EbsVolumeType": {
            "Type": "String",
            "Description": "Optional - Specifies the Type of (Amazon EBS) volume",
            "Default": "",
            "AllowedValues": [
                "",
                "standard",
                "io1",
                "gp2",
                "sc1",
                "st1"
            ],
            "ConstraintDescription": "Must be a valid EC2 volume type."
        },
        "RootDeviceName": {
            "Type": "String",
            "Description": "Optional - Specifies the device mapping for the root EBS volume.",
            "Default": "/dev/xvda"
        },
        "DeviceName": {
            "Type": "String",
            "Description": "Optional - Specifies the device mapping for the EBS volume used for data storage. Only applicable to AL1."
        },
        "UseSpot": {
            "Type": "String",
            "Default": "false"
        },
        "IamSpotFleetRoleArn": {
            "Type": "String",
            "Default": ""
        },
        "SpotPrice": {
            "Type": "String",
            "Default": ""
        },
        "SpotAllocationStrategy": {
            "Type": "String",
            "Default": "diversified",
            "AllowedValues": [
                "lowestPrice",
                "diversified"
            ]
        },
        "IsWindows": {
            "Type": "String",
            "Default": "false"
        },
        "ConfigureRootVolume": {
            "Type": "String",
            "Description": "Optional - Specifies if there should be customization of the root volume",
            "Default": "false"
        },
        "ConfigureDataVolume": {
            "Type": "String",
            "Description": "Optional - Specifies if there should be customization of the data volume",
            "Default": "true"
        },
        "AutoAssignPublicIp": {
            "Type": "String",
            "Default": "INHERIT"
        }
    },
    "Conditions": {
        "CreateEC2LCWithKeyPair": {
            "Fn::Not": [
                {
                    "Fn::Equals": [
                        {
                            "Ref": "KeyName"
                        },
                        ""
                    ]
                }
            ]
        },
        "SetEndpointToECSAgent": {
            "Fn::Not": [
                {
                    "Fn::Equals": [
                        {
                            "Ref": "EcsEndpoint"
                        },
                        ""
                    ]
                }
            ]
        },
        "CreateNewSecurityGroup": {
            "Fn::Equals": [
                {
                    "Ref": "SecurityGroupId"
                },
                ""
            ]
        },
        "CreateNewVpc": {
            "Fn::Equals": [
                {
                    "Ref": "VpcId"
                },
                ""
            ]
        },
        "CreateSubnet1": {
            "Fn::And": [
                {
                    "Fn::Not": [
                        {
                            "Fn::Equals": [
                                {
                                    "Ref": "SubnetCidr1"
                                },
                                ""
                            ]
                        }
                    ]
                },
                {
                    "Condition": "CreateNewVpc"
                }
            ]
        },
        "CreateSubnet2": {
            "Fn::And": [
                {
                    "Fn::Not": [
                        {
                            "Fn::Equals": [
                                {
                                    "Ref": "SubnetCidr2"
                                },
                                ""
                            ]
                        }
                    ]
                },
                {
                    "Condition": "CreateSubnet1"
                }
            ]
        },
        "CreateSubnet3": {
            "Fn::And": [
                {
                    "Fn::Not": [
                        {
                            "Fn::Equals": [
                                {
                                    "Ref": "SubnetCidr3"
                                },
                                ""
                            ]
                        }
                    ]
                },
                {
                    "Condition": "CreateSubnet2"
                }
            ]
        },
        "CreateWithSpot": {
            "Fn::Equals": [
                {
                    "Ref": "UseSpot"
                },
                "true"
            ]
        },
        "CreateWithASG": {
            "Fn::Not": [
                {
                    "Condition": "CreateWithSpot"
                }
            ]
        },
        "CreateWithSpotPrice": {
            "Fn::Not": [
                {
                    "Fn::Equals": [
                        {
                            "Ref": "SpotPrice"
                        },
                        ""
                    ]
                }
            ]
        },
        "IsConfiguringRootVolume": {
            "Fn::Equals": [
                {
                    "Ref": "ConfigureRootVolume"
                },
                "true"
            ]
        },
        "IsConfiguringDataVolume": {
            "Fn::Equals": [
                {
                    "Ref": "ConfigureDataVolume"
                },
                "true"
            ]
        },
        "IsInheritPublicIp": {
            "Fn::Equals": [
                {
                    "Ref": "AutoAssignPublicIp"
                },
                "INHERIT"
            ]
        }
    },
    "Resources": {
        "Vpc": {
            "Condition": "CreateSubnet1",
            "Type": "AWS::EC2::VPC",
            "Properties": {
                "CidrBlock": {
                    "Ref": "VpcCidr"
                },
                "EnableDnsSupport": True,
                "EnableDnsHostnames": True
            }
        },
        "PubSubnetAz1": {
            "Condition": "CreateSubnet1",
            "Type": "AWS::EC2::Subnet",
            "Properties": {
                "VpcId": {
                    "Ref": "Vpc"
                },
                "CidrBlock": {
                    "Ref": "SubnetCidr1"
                },
                "AvailabilityZone": {
                    "Fn::Select": [
                        0,
                        {
                            "Ref": "VpcAvailabilityZones"
                        }
                    ]
                },
                "MapPublicIpOnLaunch": True
            }
        },
        "PubSubnetAz2": {
            "Condition": "CreateSubnet2",
            "Type": "AWS::EC2::Subnet",
            "Properties": {
                "VpcId": {
                    "Ref": "Vpc"
                },
                "CidrBlock": {
                    "Ref": "SubnetCidr2"
                },
                "AvailabilityZone": {
                    "Fn::Select": [
                        1,
                        {
                            "Ref": "VpcAvailabilityZones"
                        }
                    ]
                },
                "MapPublicIpOnLaunch": True
            }
        },
        "PubSubnetAz3": {
            "Condition": "CreateSubnet3",
            "Type": "AWS::EC2::Subnet",
            "Properties": {
                "VpcId": {
                    "Ref": "Vpc"
                },
                "CidrBlock": {
                    "Ref": "SubnetCidr3"
                },
                "AvailabilityZone": {
                    "Fn::Select": [
                        2,
                        {
                            "Ref": "VpcAvailabilityZones"
                        }
                    ]
                },
                "MapPublicIpOnLaunch": True
            }
        },
        "InternetGateway": {
            "Condition": "CreateSubnet1",
            "Type": "AWS::EC2::InternetGateway"
        },
        "AttachGateway": {
            "Condition": "CreateSubnet1",
            "Type": "AWS::EC2::VPCGatewayAttachment",
            "Properties": {
                "VpcId": {
                    "Ref": "Vpc"
                },
                "InternetGatewayId": {
                    "Ref": "InternetGateway"
                }
            }
        },
        "RouteViaIgw": {
            "Condition": "CreateSubnet1",
            "Type": "AWS::EC2::RouteTable",
            "Properties": {
                "VpcId": {
                    "Ref": "Vpc"
                }
            }
        },
        "PublicRouteViaIgw": {
            "Condition": "CreateSubnet1",
            "Type": "AWS::EC2::Route",
            "DependsOn": "AttachGateway",
            "Properties": {
                "RouteTableId": {
                    "Ref": "RouteViaIgw"
                },
                "DestinationCidrBlock": "0.0.0.0/0",
                "GatewayId": {
                    "Ref": "InternetGateway"
                }
            }
        },
        "PubSubnet1RouteTableAssociation": {
            "Condition": "CreateSubnet1",
            "Type": "AWS::EC2::SubnetRouteTableAssociation",
            "Properties": {
                "SubnetId": {
                    "Ref": "PubSubnetAz1"
                },
                "RouteTableId": {
                    "Ref": "RouteViaIgw"
                }
            }
        },
        "PubSubnet2RouteTableAssociation": {
            "Condition": "CreateSubnet2",
            "Type": "AWS::EC2::SubnetRouteTableAssociation",
            "Properties": {
                "SubnetId": {
                    "Ref": "PubSubnetAz2"
                },
                "RouteTableId": {
                    "Ref": "RouteViaIgw"
                }
            }
        },
        "PubSubnet3RouteTableAssociation": {
            "Condition": "CreateSubnet3",
            "Type": "AWS::EC2::SubnetRouteTableAssociation",
            "Properties": {
                "SubnetId": {
                    "Ref": "PubSubnetAz3"
                },
                "RouteTableId": {
                    "Ref": "RouteViaIgw"
                }
            }
        },
        "EcsSecurityGroup": {
            "Condition": "CreateNewSecurityGroup",
            "Type": "AWS::EC2::SecurityGroup",
            "Properties": {
                "GroupDescription": "ECS Allowed Ports",
                "VpcId": {
                    "Fn::If": [
                        "CreateSubnet1",
                        {
                            "Ref": "Vpc"
                        },
                        {
                            "Ref": "VpcId"
                        }
                    ]
                },
                "SecurityGroupIngress": {
                    "IpProtocol": "tcp",
                    "FromPort": {
                        "Ref": "SecurityIngressFromPort"
                    },
                    "ToPort": {
                        "Ref": "SecurityIngressToPort"
                    },
                    "CidrIp": {
                        "Ref": "SecurityIngressCidrIp"
                    }
                }
            }
        },
        "EcsInstanceLc": {
            "Type": "AWS::AutoScaling::LaunchConfiguration",
            "Condition": "CreateWithASG",
            "Properties": {
                "ImageId": {
                    "Ref": "EcsAmiId"
                },
                "InstanceType": {
                    "Fn::Select": [
                        0,
                        {
                            "Ref": "EcsInstanceType"
                        }
                    ]
                },
                "AssociatePublicIpAddress": {
                    "Fn::If": [
                        "IsInheritPublicIp",
                        {
                            "Ref": "AWS::NoValue"
                        },
                        {
                            "Ref": "AutoAssignPublicIp"
                        }
                    ]
                },
                "IamInstanceProfile": {
                    "Ref": "IamRoleInstanceProfile"
                },
                "KeyName": {
                    "Fn::If": [
                        "CreateEC2LCWithKeyPair",
                        {
                            "Ref": "KeyName"
                        },
                        {
                            "Ref": "AWS::NoValue"
                        }
                    ]
                },
                "SecurityGroups": [
                    {
                        "Fn::If": [
                            "CreateNewSecurityGroup",
                            {
                                "Ref": "EcsSecurityGroup"
                            },
                            {
                                "Ref": "SecurityGroupId"
                            }
                        ]
                    }
                ],
                "BlockDeviceMappings": [
                    {
                        "Fn::If": [
                            "IsConfiguringRootVolume",
                            {
                                "DeviceName": {
                                    "Ref": "RootDeviceName"
                                },
                                "Ebs": {
                                    "VolumeSize": {
                                        "Ref": "RootEbsVolumeSize"
                                    },
                                    "VolumeType": {
                                        "Ref": "EbsVolumeType"
                                    }
                                }
                            },
                            {
                                "Ref": "AWS::NoValue"
                            }
                        ]
                    },
                    {
                        "Fn::If": [
                            "IsConfiguringDataVolume",
                            {
                                "DeviceName": {
                                    "Ref": "DeviceName"
                                },
                                "Ebs": {
                                    "VolumeSize": {
                                        "Ref": "EbsVolumeSize"
                                    },
                                    "VolumeType": {
                                        "Ref": "EbsVolumeType"
                                    }
                                }
                            },
                            {
                                "Ref": "AWS::NoValue"
                            }
                        ]
                    }
                ],
                "UserData": {
                        "Fn::Base64": {
                            "Fn::Join":["",[
                                "#!/bin/bash -ex\n",
                                "echo ECS_CLUSTER=",{"Ref":"EcsClusterName"}," | sudo tee /etc/ecs/ecs.config\n",
                                "echo ECS_BACKEND_HOST= | sudo tee -a /etc/ecs/ecs.config\n",
                                "echo kvs_stream=",{"Ref":"KvsStream"}," | sudo tee -a /etc/environment\n",
                                "echo sqs_queue=",{"Ref":"SqsQueue"}," | sudo tee -a /etc/environment\n",
                                "source /etc/environment\n"
                        ]]
                    }
                }
            }
        },
        "EcsInstanceAsg": {
            "Type": "AWS::AutoScaling::AutoScalingGroup",
            "Condition": "CreateWithASG",
            "Properties": {
                "VPCZoneIdentifier": {
                    "Fn::If": [
                        "CreateSubnet1",
                        {
                            "Fn::If": [
                                "CreateSubnet2",
                                {
                                    "Fn::If": [
                                        "CreateSubnet3",
                                        [
                                            {
                                                "Fn::Sub": "${PubSubnetAz1}, ${PubSubnetAz2}, ${PubSubnetAz3}"
                                            }
                                        ],
                                        [
                                            {
                                                "Fn::Sub": "${PubSubnetAz1}, ${PubSubnetAz2}"
                                            }
                                        ]
                                    ]
                                },
                                [
                                    {
                                        "Fn::Sub": "${PubSubnetAz1}"
                                    }
                                ]
                            ]
                        },
                        {
                            "Ref": "SubnetIds"
                        }
                    ]
                },
                "LaunchConfigurationName": {
                    "Ref": "EcsInstanceLc"
                },
                "MinSize": "0",
                "MaxSize": {
                    "Ref": "AsgMaxSize"
                },
                "DesiredCapacity": {
                    "Ref": "AsgMaxSize"
                },
                "Tags": [
                    {
                        "Key": "Name",
                        "Value": {
                            "Fn::Sub": "ECS Instance - ${AWS::StackName}"
                        },
                        "PropagateAtLaunch": True
                    },
                    {
                        "Key": "Description",
                        "Value": "This instance is the part of the Auto Scaling group which was created through ECS Console",
                        "PropagateAtLaunch": True
                    }
                ]
            }
        },
        "EcsSpotFleet": {
            "Condition": "CreateWithSpot",
            "Type": "AWS::EC2::SpotFleet",
            "Properties": {
                "SpotFleetRequestConfigData": {
                    "AllocationStrategy": {
                        "Ref": "SpotAllocationStrategy"
                    },
                    "IamFleetRole": {
                        "Ref": "IamSpotFleetRoleArn"
                    },
                    "TargetCapacity": {
                        "Ref": "AsgMaxSize"
                    },
                    "SpotPrice": {
                        "Fn::If": [
                            "CreateWithSpotPrice",
                            {
                                "Ref": "SpotPrice"
                            },
                            {
                                "Ref": "AWS::NoValue"
                            }
                        ]
                    },
                    "TerminateInstancesWithExpiration": True,
                    "LaunchSpecifications": [
                        {
                            "IamInstanceProfile": {
                                "Arn": {
                                    "Ref": "IamRoleInstanceProfile"
                                }
                            },
                            "ImageId": {
                                "Ref": "EcsAmiId"
                            },
                            "InstanceType": {
                                "Fn::Select": [
                                    0,
                                    {
                                        "Ref": "EcsInstanceType"
                                    }
                                ]
                            },
                            "KeyName": {
                                "Fn::If": [
                                    "CreateEC2LCWithKeyPair",
                                    {
                                        "Ref": "KeyName"
                                    },
                                    {
                                        "Ref": "AWS::NoValue"
                                    }
                                ]
                            },
                            "Monitoring": {
                                "Enabled": True
                            },
                            "SecurityGroups": [
                                {
                                    "GroupId": {
                                        "Fn::If": [
                                            "CreateNewSecurityGroup",
                                            {
                                                "Ref": "EcsSecurityGroup"
                                            },
                                            {
                                                "Ref": "SecurityGroupId"
                                            }
                                        ]
                                    }
                                }
                            ],
                            "SubnetId": {
                                "Fn::If": [
                                    "CreateSubnet1",
                                    {
                                        "Fn::If": [
                                            "CreateSubnet2",
                                            {
                                                "Fn::If": [
                                                    "CreateSubnet3",
                                                    {
                                                        "Fn::Join": [
                                                            ",",
                                                            [
                                                                {
                                                                    "Ref": "PubSubnetAz1"
                                                                },
                                                                {
                                                                    "Ref": "PubSubnetAz2"
                                                                },
                                                                {
                                                                    "Ref": "PubSubnetAz3"
                                                                }
                                                            ]
                                                        ]
                                                    },
                                                    {
                                                        "Fn::Join": [
                                                            ",",
                                                            [
                                                                {
                                                                    "Ref": "PubSubnetAz1"
                                                                },
                                                                {
                                                                    "Ref": "PubSubnetAz2"
                                                                }
                                                            ]
                                                        ]
                                                    }
                                                ]
                                            },
                                            {
                                                "Ref": "PubSubnetAz1"
                                            }
                                        ]
                                    },
                                    {
                                        "Fn::Join": [
                                            ",",
                                            {
                                                "Ref": "SubnetIds"
                                            }
                                        ]
                                    }
                                ]
                            },
                            "BlockDeviceMappings": [
                                {
                                    "DeviceName": {
                                        "Ref": "DeviceName"
                                    },
                                    "Ebs": {
                                        "VolumeSize": {
                                            "Ref": "EbsVolumeSize"
                                        },
                                        "VolumeType": {
                                            "Ref": "EbsVolumeType"
                                        }
                                    }
                                }
                            ],
                            "UserData": {
                                "Fn::Base64": {
                                    "Fn::Join":["",[
                                        "#!/bin/bash -ex\n",
                                        "echo ECS_CLUSTER=",{"Ref":"EcsClusterName"}," | sudo tee /etc/ecs/ecs.config\n",
                                        "echo ECS_BACKEND_HOST= | sudo tee -a /etc/ecs/ecs.config\n",
                                        "echo kvs_stream=",{"Ref":"KvsStream"}," | sudo tee -a /etc/environment\n",
                                        "echo sqs_queue=",{"Ref":"SqsQueue"}," | sudo tee -a /etc/environment\n",
                                        "source /etc/environment\n"
                                    ]]
                                }
                            }
                        }
                    ]
                }
            }
        }
    },
    "Outputs": {
        "EcsInstanceAsgName": {
            "Condition": "CreateWithASG",
            "Description": "Auto Scaling Group Name for ECS Instances",
            "Value": {
                "Ref": "EcsInstanceAsg"
            }
        },
        "EcsSpotFleetRequestId": {
            "Condition": "CreateWithSpot",
            "Description": "Spot Fleet Request for ECS Instances",
            "Value": {
                "Ref": "EcsSpotFleet"
            }
        },
        "UsedByECSCreateCluster": {
            "Description": "Flag used by ECS Create Cluster Wizard",
            "Value": "true"
        },
        "TemplateVersion": {
            "Description": "The version of the template used by Create Cluster Wizard",
            "Value": "2.0.0"
        }
    }
}