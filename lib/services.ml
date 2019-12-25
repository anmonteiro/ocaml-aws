type t =
  | Forecast 
  | CodeBuild 
  | IoT_Events_Data 
  | CodeGuruProfiler 
  | Kinesis 
  | Kinesis_Video 
  | Pinpoint 
  | Chime 
  | Organizations 
  | Shield 
  | SSM 
  | Signer 
  | Service_Catalog 
  | LakeFormation 
  | Secrets_Manager 
  | MediaConnect 
  | KMS 
  | QuickSight 
  | WorkMail 
  | FraudDetector 
  | Elastic_Transcoder 
  | CloudWatch 
  | Glue 
  | Elastic_Inference 
  | Personalize_Events 
  | S3 
  | SESv2 
  | EMR 
  | Personalize 
  | Outposts 
  | WorkDocs 
  | NetworkManager 
  | Kinesis_Video_Signaling 
  | MediaPackage 
  | MediaLive 
  | MediaConvert 
  | SNS 
  | DataSync 
  | Macie 
  | Cognito_Identity_Provider 
  | ACM_PCA 
  | IoTAnalytics 
  | GroundStation 
  | CloudHSM 
  | Directory_Service 
  | SMS 
  | Config_Service 
  | Inspector 
  | Translate 
  | FMS 
  | S3_Control 
  | Kinesis_Analytics_V2 
  | Marketplace_Commerce_Analytics 
  | IoTSecureTunneling 
  | CloudFront 
  | WAFV2 
  | IoTThingsGraph 
  | Health 
  | WorkMailMessageFlow 
  | MediaStore_Data 
  | EC2_Instance_Connect 
  | ComprehendMedical 
  | AccessAnalyzer 
  | Glacier 
  | Lightsail 
  | Imagebuilder 
  | Application_Discovery_Service 
  | ServerlessApplicationRepository 
  | Elastic_Beanstalk 
  | CloudSearch_Domain 
  | Neptune 
  | Lex_Runtime_Service 
  | Transfer 
  | WAF_Regional 
  | QLDB 
  | ECR 
  | Kinesis_Video_Media 
  | DynamoDB 
  | Route_53_Domains 
  | Auto_Scaling_Plans 
  | Storage_Gateway 
  | Service_Quotas 
  | ImportExport 
  | ECS 
  | Application_Auto_Scaling 
  | CloudSearch 
  | Route53Resolver 
  | WorkSpaces 
  | Machine_Learning 
  | Pinpoint_SMS_Voice 
  | FSx 
  | CodePipeline 
  | Elastic_Load_Balancing 
  | Schemas 
  | SQS 
  | App_Mesh 
  | IoT 
  | SSO_OIDC 
  | Codestar_notifications 
  | EBS 
  | Amplify 
  | MigrationHub_Config 
  | Redshift 
  | GameLift 
  | Lex_Model_Building_Service 
  | CloudTrail 
  | Migration_Hub 
  | Resource_Groups 
  | MediaTailor 
  | PI 
  | IoT_1Click_Devices_Service 
  | AppConfig 
  | ConnectParticipant 
  | IAM 
  | MediaStore 
  | Cloud9 
  | SageMaker_Runtime 
  | SSO 
  | Snowball 
  | CloudWatch_Logs 
  | Kinesis_Analytics 
  | OpsWorks 
  | Textract 
  | Compute_Optimizer 
  | EKS 
  | Support 
  | MTurk 
  | ApiGatewayV2 
  | Marketplace_Metering 
  | IoT_Data_Plane 
  | Kafka 
  | Mobile 
  | CodeDeploy 
  | CloudHSM_V2 
  | Batch 
  | IoT_1Click_Projects 
  | Savingsplans 
  | SimpleDB 
  | CodeGuru_Reviewer 
  | AppSync 
  | DLM 
  | Budgets 
  | Pinpoint_Email 
  | Detective 
  | Lambda 
  | IoT_Events 
  | Marketplace_Entitlement_Service 
  | ManagedBlockchain 
  | ServiceDiscovery 
  | WAF 
  | Direct_Connect 
  | Cost_and_Usage_Report_Service 
  | Mq 
  | License_Manager 
  | CodeStar_connections 
  | CodeStar 
  | Personalize_Runtime 
  | CloudDirectory 
  | Cognito_Sync 
  | GuardDuty 
  | WorkLink 
  | SageMaker_A2I_Runtime 
  | Elasticsearch_Service 
  | DAX 
  | OpsWorksCM 
  | DocDB 
  | Firehose 
  | Database_Migration_Service 
  | DynamoDB_Streams 
  | Global_Accelerator 
  | SES 
  | Application_Insights 
  | Alexa_For_Business 
  | RoboMaker 
  | EventBridge 
  | Auto_Scaling 
  | Elastic_Load_Balancing_v2 
  | Greengrass 
  | SecurityHub 
  | Backup 
  | CloudFormation 
  | Kendra 
  | Connect 
  | ElastiCache 
  | Cost_Explorer 
  | Comprehend 
  | Device_Farm 
  | RDS_Data 
  | Rekognition 
  | AppStream 
  | Polly 
  | RDS 
  | Pricing 
  | SWF 
  | QLDB_Session 
  | Data_Pipeline 
  | Transcribe 
  | SFN 
  | CodeCommit 
  | Resource_Groups_Tagging_API 
  | Forecastquery 
  | Marketplace_Catalog 
  | ApiGatewayManagementApi 
  | XRay 
  | API_Gateway 
  | RAM 
  | EFS 
  | Cognito_Identity 
  | DataExchange 
  | STS 
  | SageMaker 
  | Kinesis_Video_Archived_Media 
  | ACM 
  | Athena 
  | Route_53 
  | IoT_Jobs_Data_Plane 
  | MediaPackage_Vod 
  | EC2 
let to_string svc =
  match svc with
  | Forecast -> "forecast"
  | CodeBuild -> "codebuild"
  | IoT_Events_Data -> "data.iotevents"
  | CodeGuruProfiler -> "codeguru-profiler"
  | Kinesis -> "kinesis"
  | Kinesis_Video -> "kinesisvideo"
  | Pinpoint -> "pinpoint"
  | Chime -> "chime"
  | Organizations -> "organizations"
  | Shield -> "shield"
  | SSM -> "ssm"
  | Signer -> "signer"
  | Service_Catalog -> "servicecatalog"
  | LakeFormation -> "lakeformation"
  | Secrets_Manager -> "secretsmanager"
  | MediaConnect -> "mediaconnect"
  | KMS -> "kms"
  | QuickSight -> "quicksight"
  | WorkMail -> "workmail"
  | FraudDetector -> "frauddetector"
  | Elastic_Transcoder -> "elastictranscoder"
  | CloudWatch -> "monitoring"
  | Glue -> "glue"
  | Elastic_Inference -> "api.elastic-inference"
  | Personalize_Events -> "personalize-events"
  | S3 -> "s3"
  | SESv2 -> "email"
  | EMR -> "elasticmapreduce"
  | Personalize -> "personalize"
  | Outposts -> "outposts"
  | WorkDocs -> "workdocs"
  | NetworkManager -> "networkmanager"
  | Kinesis_Video_Signaling -> "kinesisvideo"
  | MediaPackage -> "mediapackage"
  | MediaLive -> "medialive"
  | MediaConvert -> "mediaconvert"
  | SNS -> "sns"
  | DataSync -> "datasync"
  | Macie -> "macie"
  | Cognito_Identity_Provider -> "cognito-idp"
  | ACM_PCA -> "acm-pca"
  | IoTAnalytics -> "iotanalytics"
  | GroundStation -> "groundstation"
  | CloudHSM -> "cloudhsm"
  | Directory_Service -> "ds"
  | SMS -> "sms"
  | Config_Service -> "config"
  | Inspector -> "inspector"
  | Translate -> "translate"
  | FMS -> "fms"
  | S3_Control -> "s3-control"
  | Kinesis_Analytics_V2 -> "kinesisanalytics"
  | Marketplace_Commerce_Analytics -> "marketplacecommerceanalytics"
  | IoTSecureTunneling -> "api.tunneling.iot"
  | CloudFront -> "cloudfront"
  | WAFV2 -> "wafv2"
  | IoTThingsGraph -> "iotthingsgraph"
  | Health -> "health"
  | WorkMailMessageFlow -> "workmailmessageflow"
  | MediaStore_Data -> "data.mediastore"
  | EC2_Instance_Connect -> "ec2-instance-connect"
  | ComprehendMedical -> "comprehendmedical"
  | AccessAnalyzer -> "access-analyzer"
  | Glacier -> "glacier"
  | Lightsail -> "lightsail"
  | Imagebuilder -> "imagebuilder"
  | Application_Discovery_Service -> "discovery"
  | ServerlessApplicationRepository -> "serverlessrepo"
  | Elastic_Beanstalk -> "elasticbeanstalk"
  | CloudSearch_Domain -> "cloudsearchdomain"
  | Neptune -> "rds"
  | Lex_Runtime_Service -> "runtime.lex"
  | Transfer -> "transfer"
  | WAF_Regional -> "waf-regional"
  | QLDB -> "qldb"
  | ECR -> "api.ecr"
  | Kinesis_Video_Media -> "kinesisvideo"
  | DynamoDB -> "dynamodb"
  | Route_53_Domains -> "route53domains"
  | Auto_Scaling_Plans -> "autoscaling-plans"
  | Storage_Gateway -> "storagegateway"
  | Service_Quotas -> "servicequotas"
  | ImportExport -> "importexport"
  | ECS -> "ecs"
  | Application_Auto_Scaling -> "application-autoscaling"
  | CloudSearch -> "cloudsearch"
  | Route53Resolver -> "route53resolver"
  | WorkSpaces -> "workspaces"
  | Machine_Learning -> "machinelearning"
  | Pinpoint_SMS_Voice -> "sms-voice.pinpoint"
  | FSx -> "fsx"
  | CodePipeline -> "codepipeline"
  | Elastic_Load_Balancing -> "elasticloadbalancing"
  | Schemas -> "schemas"
  | SQS -> "sqs"
  | App_Mesh -> "appmesh"
  | IoT -> "iot"
  | SSO_OIDC -> "oidc"
  | Codestar_notifications -> "codestar-notifications"
  | EBS -> "ebs"
  | Amplify -> "amplify"
  | MigrationHub_Config -> "migrationhub-config"
  | Redshift -> "redshift"
  | GameLift -> "gamelift"
  | Lex_Model_Building_Service -> "models.lex"
  | CloudTrail -> "cloudtrail"
  | Migration_Hub -> "mgh"
  | Resource_Groups -> "resource-groups"
  | MediaTailor -> "api.mediatailor"
  | PI -> "pi"
  | IoT_1Click_Devices_Service -> "devices.iot1click"
  | AppConfig -> "appconfig"
  | ConnectParticipant -> "participant.connect"
  | IAM -> "iam"
  | MediaStore -> "mediastore"
  | Cloud9 -> "cloud9"
  | SageMaker_Runtime -> "runtime.sagemaker"
  | SSO -> "portal.sso"
  | Snowball -> "snowball"
  | CloudWatch_Logs -> "logs"
  | Kinesis_Analytics -> "kinesisanalytics"
  | OpsWorks -> "opsworks"
  | Textract -> "textract"
  | Compute_Optimizer -> "compute-optimizer"
  | EKS -> "eks"
  | Support -> "support"
  | MTurk -> "mturk-requester"
  | ApiGatewayV2 -> "apigateway"
  | Marketplace_Metering -> "metering.marketplace"
  | IoT_Data_Plane -> "data.iot"
  | Kafka -> "kafka"
  | Mobile -> "mobile"
  | CodeDeploy -> "codedeploy"
  | CloudHSM_V2 -> "cloudhsmv2"
  | Batch -> "batch"
  | IoT_1Click_Projects -> "projects.iot1click"
  | Savingsplans -> "savingsplans"
  | SimpleDB -> "sdb"
  | CodeGuru_Reviewer -> "codeguru-reviewer"
  | AppSync -> "appsync"
  | DLM -> "dlm"
  | Budgets -> "budgets"
  | Pinpoint_Email -> "email"
  | Detective -> "api.detective"
  | Lambda -> "lambda"
  | IoT_Events -> "iotevents"
  | Marketplace_Entitlement_Service -> "entitlement.marketplace"
  | ManagedBlockchain -> "managedblockchain"
  | ServiceDiscovery -> "servicediscovery"
  | WAF -> "waf"
  | Direct_Connect -> "directconnect"
  | Cost_and_Usage_Report_Service -> "cur"
  | Mq -> "mq"
  | License_Manager -> "license-manager"
  | CodeStar_connections -> "codestar-connections"
  | CodeStar -> "codestar"
  | Personalize_Runtime -> "personalize-runtime"
  | CloudDirectory -> "clouddirectory"
  | Cognito_Sync -> "cognito-sync"
  | GuardDuty -> "guardduty"
  | WorkLink -> "worklink"
  | SageMaker_A2I_Runtime -> "a2i-runtime.sagemaker"
  | Elasticsearch_Service -> "es"
  | DAX -> "dax"
  | OpsWorksCM -> "opsworks-cm"
  | DocDB -> "rds"
  | Firehose -> "firehose"
  | Database_Migration_Service -> "dms"
  | DynamoDB_Streams -> "streams.dynamodb"
  | Global_Accelerator -> "globalaccelerator"
  | SES -> "email"
  | Application_Insights -> "applicationinsights"
  | Alexa_For_Business -> "a4b"
  | RoboMaker -> "robomaker"
  | EventBridge -> "events"
  | Auto_Scaling -> "autoscaling"
  | Elastic_Load_Balancing_v2 -> "elasticloadbalancing"
  | Greengrass -> "greengrass"
  | SecurityHub -> "securityhub"
  | Backup -> "backup"
  | CloudFormation -> "cloudformation"
  | Kendra -> "kendra"
  | Connect -> "connect"
  | ElastiCache -> "elasticache"
  | Cost_Explorer -> "ce"
  | Comprehend -> "comprehend"
  | Device_Farm -> "devicefarm"
  | RDS_Data -> "rds-data"
  | Rekognition -> "rekognition"
  | AppStream -> "appstream2"
  | Polly -> "polly"
  | RDS -> "rds"
  | Pricing -> "api.pricing"
  | SWF -> "swf"
  | QLDB_Session -> "session.qldb"
  | Data_Pipeline -> "datapipeline"
  | Transcribe -> "transcribe"
  | SFN -> "states"
  | CodeCommit -> "codecommit"
  | Resource_Groups_Tagging_API -> "tagging"
  | Forecastquery -> "forecastquery"
  | Marketplace_Catalog -> "catalog.marketplace"
  | ApiGatewayManagementApi -> "execute-api"
  | XRay -> "xray"
  | API_Gateway -> "apigateway"
  | RAM -> "ram"
  | EFS -> "elasticfilesystem"
  | Cognito_Identity -> "cognito-identity"
  | DataExchange -> "dataexchange"
  | STS -> "sts"
  | SageMaker -> "api.sagemaker"
  | Kinesis_Video_Archived_Media -> "kinesisvideo"
  | ACM -> "acm"
  | Athena -> "athena"
  | Route_53 -> "route53"
  | IoT_Jobs_Data_Plane -> "data.jobs.iot"
  | MediaPackage_Vod -> "mediapackage-vod"
  | EC2 -> "ec2"
let of_string s =
  match s with
  | "forecast" -> Some Forecast
  | "codebuild" -> Some CodeBuild
  | "data.iotevents" -> Some IoT_Events_Data
  | "codeguru-profiler" -> Some CodeGuruProfiler
  | "kinesis" -> Some Kinesis
  | "kinesisvideo" -> Some Kinesis_Video
  | "pinpoint" -> Some Pinpoint
  | "chime" -> Some Chime
  | "organizations" -> Some Organizations
  | "shield" -> Some Shield
  | "ssm" -> Some SSM
  | "signer" -> Some Signer
  | "servicecatalog" -> Some Service_Catalog
  | "lakeformation" -> Some LakeFormation
  | "secretsmanager" -> Some Secrets_Manager
  | "mediaconnect" -> Some MediaConnect
  | "kms" -> Some KMS
  | "quicksight" -> Some QuickSight
  | "workmail" -> Some WorkMail
  | "frauddetector" -> Some FraudDetector
  | "elastictranscoder" -> Some Elastic_Transcoder
  | "monitoring" -> Some CloudWatch
  | "glue" -> Some Glue
  | "api.elastic-inference" -> Some Elastic_Inference
  | "personalize-events" -> Some Personalize_Events
  | "s3" -> Some S3
  | "email" -> Some SESv2
  | "elasticmapreduce" -> Some EMR
  | "personalize" -> Some Personalize
  | "outposts" -> Some Outposts
  | "workdocs" -> Some WorkDocs
  | "networkmanager" -> Some NetworkManager
  | "kinesisvideo" -> Some Kinesis_Video_Signaling
  | "mediapackage" -> Some MediaPackage
  | "medialive" -> Some MediaLive
  | "mediaconvert" -> Some MediaConvert
  | "sns" -> Some SNS
  | "datasync" -> Some DataSync
  | "macie" -> Some Macie
  | "cognito-idp" -> Some Cognito_Identity_Provider
  | "acm-pca" -> Some ACM_PCA
  | "iotanalytics" -> Some IoTAnalytics
  | "groundstation" -> Some GroundStation
  | "cloudhsm" -> Some CloudHSM
  | "ds" -> Some Directory_Service
  | "sms" -> Some SMS
  | "config" -> Some Config_Service
  | "inspector" -> Some Inspector
  | "translate" -> Some Translate
  | "fms" -> Some FMS
  | "s3-control" -> Some S3_Control
  | "kinesisanalytics" -> Some Kinesis_Analytics_V2
  | "marketplacecommerceanalytics" -> Some Marketplace_Commerce_Analytics
  | "api.tunneling.iot" -> Some IoTSecureTunneling
  | "cloudfront" -> Some CloudFront
  | "wafv2" -> Some WAFV2
  | "iotthingsgraph" -> Some IoTThingsGraph
  | "health" -> Some Health
  | "workmailmessageflow" -> Some WorkMailMessageFlow
  | "data.mediastore" -> Some MediaStore_Data
  | "ec2-instance-connect" -> Some EC2_Instance_Connect
  | "comprehendmedical" -> Some ComprehendMedical
  | "access-analyzer" -> Some AccessAnalyzer
  | "glacier" -> Some Glacier
  | "lightsail" -> Some Lightsail
  | "imagebuilder" -> Some Imagebuilder
  | "discovery" -> Some Application_Discovery_Service
  | "serverlessrepo" -> Some ServerlessApplicationRepository
  | "elasticbeanstalk" -> Some Elastic_Beanstalk
  | "cloudsearchdomain" -> Some CloudSearch_Domain
  | "rds" -> Some Neptune
  | "runtime.lex" -> Some Lex_Runtime_Service
  | "transfer" -> Some Transfer
  | "waf-regional" -> Some WAF_Regional
  | "qldb" -> Some QLDB
  | "api.ecr" -> Some ECR
  | "kinesisvideo" -> Some Kinesis_Video_Media
  | "dynamodb" -> Some DynamoDB
  | "route53domains" -> Some Route_53_Domains
  | "autoscaling-plans" -> Some Auto_Scaling_Plans
  | "storagegateway" -> Some Storage_Gateway
  | "servicequotas" -> Some Service_Quotas
  | "importexport" -> Some ImportExport
  | "ecs" -> Some ECS
  | "application-autoscaling" -> Some Application_Auto_Scaling
  | "cloudsearch" -> Some CloudSearch
  | "route53resolver" -> Some Route53Resolver
  | "workspaces" -> Some WorkSpaces
  | "machinelearning" -> Some Machine_Learning
  | "sms-voice.pinpoint" -> Some Pinpoint_SMS_Voice
  | "fsx" -> Some FSx
  | "codepipeline" -> Some CodePipeline
  | "elasticloadbalancing" -> Some Elastic_Load_Balancing
  | "schemas" -> Some Schemas
  | "sqs" -> Some SQS
  | "appmesh" -> Some App_Mesh
  | "iot" -> Some IoT
  | "oidc" -> Some SSO_OIDC
  | "codestar-notifications" -> Some Codestar_notifications
  | "ebs" -> Some EBS
  | "amplify" -> Some Amplify
  | "migrationhub-config" -> Some MigrationHub_Config
  | "redshift" -> Some Redshift
  | "gamelift" -> Some GameLift
  | "models.lex" -> Some Lex_Model_Building_Service
  | "cloudtrail" -> Some CloudTrail
  | "mgh" -> Some Migration_Hub
  | "resource-groups" -> Some Resource_Groups
  | "api.mediatailor" -> Some MediaTailor
  | "pi" -> Some PI
  | "devices.iot1click" -> Some IoT_1Click_Devices_Service
  | "appconfig" -> Some AppConfig
  | "participant.connect" -> Some ConnectParticipant
  | "iam" -> Some IAM
  | "mediastore" -> Some MediaStore
  | "cloud9" -> Some Cloud9
  | "runtime.sagemaker" -> Some SageMaker_Runtime
  | "portal.sso" -> Some SSO
  | "snowball" -> Some Snowball
  | "logs" -> Some CloudWatch_Logs
  | "kinesisanalytics" -> Some Kinesis_Analytics
  | "opsworks" -> Some OpsWorks
  | "textract" -> Some Textract
  | "compute-optimizer" -> Some Compute_Optimizer
  | "eks" -> Some EKS
  | "support" -> Some Support
  | "mturk-requester" -> Some MTurk
  | "apigateway" -> Some ApiGatewayV2
  | "metering.marketplace" -> Some Marketplace_Metering
  | "data.iot" -> Some IoT_Data_Plane
  | "kafka" -> Some Kafka
  | "mobile" -> Some Mobile
  | "codedeploy" -> Some CodeDeploy
  | "cloudhsmv2" -> Some CloudHSM_V2
  | "batch" -> Some Batch
  | "projects.iot1click" -> Some IoT_1Click_Projects
  | "savingsplans" -> Some Savingsplans
  | "sdb" -> Some SimpleDB
  | "codeguru-reviewer" -> Some CodeGuru_Reviewer
  | "appsync" -> Some AppSync
  | "dlm" -> Some DLM
  | "budgets" -> Some Budgets
  | "email" -> Some Pinpoint_Email
  | "api.detective" -> Some Detective
  | "lambda" -> Some Lambda
  | "iotevents" -> Some IoT_Events
  | "entitlement.marketplace" -> Some Marketplace_Entitlement_Service
  | "managedblockchain" -> Some ManagedBlockchain
  | "servicediscovery" -> Some ServiceDiscovery
  | "waf" -> Some WAF
  | "directconnect" -> Some Direct_Connect
  | "cur" -> Some Cost_and_Usage_Report_Service
  | "mq" -> Some Mq
  | "license-manager" -> Some License_Manager
  | "codestar-connections" -> Some CodeStar_connections
  | "codestar" -> Some CodeStar
  | "personalize-runtime" -> Some Personalize_Runtime
  | "clouddirectory" -> Some CloudDirectory
  | "cognito-sync" -> Some Cognito_Sync
  | "guardduty" -> Some GuardDuty
  | "worklink" -> Some WorkLink
  | "a2i-runtime.sagemaker" -> Some SageMaker_A2I_Runtime
  | "es" -> Some Elasticsearch_Service
  | "dax" -> Some DAX
  | "opsworks-cm" -> Some OpsWorksCM
  | "rds" -> Some DocDB
  | "firehose" -> Some Firehose
  | "dms" -> Some Database_Migration_Service
  | "streams.dynamodb" -> Some DynamoDB_Streams
  | "globalaccelerator" -> Some Global_Accelerator
  | "email" -> Some SES
  | "applicationinsights" -> Some Application_Insights
  | "a4b" -> Some Alexa_For_Business
  | "robomaker" -> Some RoboMaker
  | "events" -> Some EventBridge
  | "autoscaling" -> Some Auto_Scaling
  | "elasticloadbalancing" -> Some Elastic_Load_Balancing_v2
  | "greengrass" -> Some Greengrass
  | "securityhub" -> Some SecurityHub
  | "backup" -> Some Backup
  | "cloudformation" -> Some CloudFormation
  | "kendra" -> Some Kendra
  | "connect" -> Some Connect
  | "elasticache" -> Some ElastiCache
  | "ce" -> Some Cost_Explorer
  | "comprehend" -> Some Comprehend
  | "devicefarm" -> Some Device_Farm
  | "rds-data" -> Some RDS_Data
  | "rekognition" -> Some Rekognition
  | "appstream2" -> Some AppStream
  | "polly" -> Some Polly
  | "rds" -> Some RDS
  | "api.pricing" -> Some Pricing
  | "swf" -> Some SWF
  | "session.qldb" -> Some QLDB_Session
  | "datapipeline" -> Some Data_Pipeline
  | "transcribe" -> Some Transcribe
  | "states" -> Some SFN
  | "codecommit" -> Some CodeCommit
  | "tagging" -> Some Resource_Groups_Tagging_API
  | "forecastquery" -> Some Forecastquery
  | "catalog.marketplace" -> Some Marketplace_Catalog
  | "execute-api" -> Some ApiGatewayManagementApi
  | "xray" -> Some XRay
  | "apigateway" -> Some API_Gateway
  | "ram" -> Some RAM
  | "elasticfilesystem" -> Some EFS
  | "cognito-identity" -> Some Cognito_Identity
  | "dataexchange" -> Some DataExchange
  | "sts" -> Some STS
  | "api.sagemaker" -> Some SageMaker
  | "kinesisvideo" -> Some Kinesis_Video_Archived_Media
  | "acm" -> Some ACM
  | "athena" -> Some Athena
  | "route53" -> Some Route_53
  | "data.jobs.iot" -> Some IoT_Jobs_Data_Plane
  | "mediapackage-vod" -> Some MediaPackage_Vod
  | "ec2" -> Some EC2
  | _ -> None[@@ocaml.warning "-11"]
let full_name svc =
  match svc with
  | Forecast -> "Amazon Forecast Service"
  | CodeBuild -> "AWS CodeBuild"
  | IoT_Events_Data -> "AWS IoT Events Data"
  | CodeGuruProfiler -> "Amazon CodeGuru Profiler"
  | Kinesis -> "Amazon Kinesis"
  | Kinesis_Video -> "Amazon Kinesis Video Streams"
  | Pinpoint -> "Amazon Pinpoint"
  | Chime -> "Amazon Chime"
  | Organizations -> "AWS Organizations"
  | Shield -> "AWS Shield"
  | SSM -> "Amazon Simple Systems Manager (SSM)"
  | Signer -> "AWS Signer"
  | Service_Catalog -> "AWS Service Catalog"
  | LakeFormation -> "AWS Lake Formation"
  | Secrets_Manager -> "AWS Secrets Manager"
  | MediaConnect -> "AWS MediaConnect"
  | KMS -> "AWS Key Management Service"
  | QuickSight -> "Amazon QuickSight"
  | WorkMail -> "Amazon WorkMail"
  | FraudDetector -> "Amazon Fraud Detector"
  | Elastic_Transcoder -> "Amazon Elastic Transcoder"
  | CloudWatch -> "Amazon CloudWatch"
  | Glue -> "AWS Glue"
  | Elastic_Inference -> "Amazon Elastic  Inference"
  | Personalize_Events -> "Amazon Personalize Events"
  | S3 -> "Amazon Simple Storage Service"
  | SESv2 -> "Amazon Simple Email Service"
  | EMR -> "Amazon Elastic MapReduce"
  | Personalize -> "Amazon Personalize"
  | Outposts -> "AWS Outposts"
  | WorkDocs -> "Amazon WorkDocs"
  | NetworkManager -> "AWS Network Manager"
  | Kinesis_Video_Signaling -> "Amazon Kinesis Video Signaling Channels"
  | MediaPackage -> "AWS Elemental MediaPackage"
  | MediaLive -> "AWS Elemental MediaLive"
  | MediaConvert -> "AWS Elemental MediaConvert"
  | SNS -> "Amazon Simple Notification Service"
  | DataSync -> "AWS DataSync"
  | Macie -> "Amazon Macie"
  | Cognito_Identity_Provider -> "Amazon Cognito Identity Provider"
  | ACM_PCA -> "AWS Certificate Manager Private Certificate Authority"
  | IoTAnalytics -> "AWS IoT Analytics"
  | GroundStation -> "AWS Ground Station"
  | CloudHSM -> "Amazon CloudHSM"
  | Directory_Service -> "AWS Directory Service"
  | SMS -> "AWS Server Migration Service"
  | Config_Service -> "AWS Config"
  | Inspector -> "Amazon Inspector"
  | Translate -> "Amazon Translate"
  | FMS -> "Firewall Management Service"
  | S3_Control -> "AWS S3 Control"
  | Kinesis_Analytics_V2 -> "Amazon Kinesis Analytics"
  | Marketplace_Commerce_Analytics -> "AWS Marketplace Commerce Analytics"
  | IoTSecureTunneling -> "AWS IoT Secure Tunneling"
  | CloudFront -> "Amazon CloudFront"
  | WAFV2 -> "AWS WAFV2"
  | IoTThingsGraph -> "AWS IoT Things Graph"
  | Health -> "AWS Health APIs and Notifications"
  | WorkMailMessageFlow -> "Amazon WorkMail Message Flow"
  | MediaStore_Data -> "AWS Elemental MediaStore Data Plane"
  | EC2_Instance_Connect -> "AWS EC2 Instance Connect"
  | ComprehendMedical -> "AWS Comprehend Medical"
  | AccessAnalyzer -> "Access Analyzer"
  | Glacier -> "Amazon Glacier"
  | Lightsail -> "Amazon Lightsail"
  | Imagebuilder -> "EC2 Image Builder"
  | Application_Discovery_Service -> "AWS Application Discovery Service"
  | ServerlessApplicationRepository -> "AWSServerlessApplicationRepository"
  | Elastic_Beanstalk -> "AWS Elastic Beanstalk"
  | CloudSearch_Domain -> "Amazon CloudSearch Domain"
  | Neptune -> "Amazon Neptune"
  | Lex_Runtime_Service -> "Amazon Lex Runtime Service"
  | Transfer -> "AWS Transfer for SFTP"
  | WAF_Regional -> "AWS WAF Regional"
  | QLDB -> "Amazon QLDB"
  | ECR -> "Amazon EC2 Container Registry"
  | Kinesis_Video_Media -> "Amazon Kinesis Video Streams Media"
  | DynamoDB -> "Amazon DynamoDB"
  | Route_53_Domains -> "Amazon Route 53 Domains"
  | Auto_Scaling_Plans -> "AWS Auto Scaling Plans"
  | Storage_Gateway -> "AWS Storage Gateway"
  | Service_Quotas -> "Service Quotas"
  | ImportExport -> "AWS Import/Export"
  | ECS -> "Amazon EC2 Container Service"
  | Application_Auto_Scaling -> "Application Auto Scaling"
  | CloudSearch -> "Amazon CloudSearch"
  | Route53Resolver -> "Amazon Route 53 Resolver"
  | WorkSpaces -> "Amazon WorkSpaces"
  | Machine_Learning -> "Amazon Machine Learning"
  | Pinpoint_SMS_Voice -> "Amazon Pinpoint SMS and Voice Service"
  | FSx -> "Amazon FSx"
  | CodePipeline -> "AWS CodePipeline"
  | Elastic_Load_Balancing -> "Elastic Load Balancing"
  | Schemas -> "Schemas"
  | SQS -> "Amazon Simple Queue Service"
  | App_Mesh -> "AWS App Mesh"
  | IoT -> "AWS IoT"
  | SSO_OIDC -> "AWS SSO OIDC"
  | Codestar_notifications -> "AWS CodeStar Notifications"
  | EBS -> "Amazon Elastic Block Store"
  | Amplify -> "AWS Amplify"
  | MigrationHub_Config -> "AWS Migration Hub Config"
  | Redshift -> "Amazon Redshift"
  | GameLift -> "Amazon GameLift"
  | Lex_Model_Building_Service -> "Amazon Lex Model Building Service"
  | CloudTrail -> "AWS CloudTrail"
  | Migration_Hub -> "AWS Migration Hub"
  | Resource_Groups -> "AWS Resource Groups"
  | MediaTailor -> "AWS MediaTailor"
  | PI -> "AWS Performance Insights"
  | IoT_1Click_Devices_Service -> "AWS IoT 1-Click Devices Service"
  | AppConfig -> "Amazon AppConfig"
  | ConnectParticipant -> "Amazon Connect Participant Service"
  | IAM -> "AWS Identity and Access Management"
  | MediaStore -> "AWS Elemental MediaStore"
  | Cloud9 -> "AWS Cloud9"
  | SageMaker_Runtime -> "Amazon SageMaker Runtime"
  | SSO -> "AWS Single Sign-On"
  | Snowball -> "Amazon Import/Export Snowball"
  | CloudWatch_Logs -> "Amazon CloudWatch Logs"
  | Kinesis_Analytics -> "Amazon Kinesis Analytics"
  | OpsWorks -> "AWS OpsWorks"
  | Textract -> "Amazon Textract"
  | Compute_Optimizer -> "AWS Compute Optimizer"
  | EKS -> "Amazon Elastic Kubernetes Service"
  | Support -> "AWS Support"
  | MTurk -> "Amazon Mechanical Turk"
  | ApiGatewayV2 -> "AmazonApiGatewayV2"
  | Marketplace_Metering -> "AWSMarketplace Metering"
  | IoT_Data_Plane -> "AWS IoT Data Plane"
  | Kafka -> "Managed Streaming for Kafka"
  | Mobile -> "AWS Mobile"
  | CodeDeploy -> "AWS CodeDeploy"
  | CloudHSM_V2 -> "AWS CloudHSM V2"
  | Batch -> "AWS Batch"
  | IoT_1Click_Projects -> "AWS IoT 1-Click Projects Service"
  | Savingsplans -> "AWS Savings Plans"
  | SimpleDB -> "Amazon SimpleDB"
  | CodeGuru_Reviewer -> "Amazon CodeGuru Reviewer"
  | AppSync -> "AWS AppSync"
  | DLM -> "Amazon Data Lifecycle Manager"
  | Budgets -> "AWS Budgets"
  | Pinpoint_Email -> "Amazon Pinpoint Email Service"
  | Detective -> "Amazon Detective"
  | Lambda -> "AWS Lambda"
  | IoT_Events -> "AWS IoT Events"
  | Marketplace_Entitlement_Service -> "AWS Marketplace Entitlement Service"
  | ManagedBlockchain -> "Amazon Managed Blockchain"
  | ServiceDiscovery -> "AWS Cloud Map"
  | WAF -> "AWS WAF"
  | Direct_Connect -> "AWS Direct Connect"
  | Cost_and_Usage_Report_Service -> "AWS Cost and Usage Report Service"
  | Mq -> "AmazonMQ"
  | License_Manager -> "AWS License Manager"
  | CodeStar_connections -> "AWS CodeStar connections"
  | CodeStar -> "AWS CodeStar"
  | Personalize_Runtime -> "Amazon Personalize Runtime"
  | CloudDirectory -> "Amazon CloudDirectory"
  | Cognito_Sync -> "Amazon Cognito Sync"
  | GuardDuty -> "Amazon GuardDuty"
  | WorkLink -> "Amazon WorkLink"
  | SageMaker_A2I_Runtime -> "Amazon Augmented AI Runtime"
  | Elasticsearch_Service -> "Amazon Elasticsearch Service"
  | DAX -> "Amazon DynamoDB Accelerator (DAX)"
  | OpsWorksCM -> "AWS OpsWorks CM"
  | DocDB -> "Amazon DocumentDB with MongoDB compatibility"
  | Firehose -> "Amazon Kinesis Firehose"
  | Database_Migration_Service -> "AWS Database Migration Service"
  | DynamoDB_Streams -> "Amazon DynamoDB Streams"
  | Global_Accelerator -> "AWS Global Accelerator"
  | SES -> "Amazon Simple Email Service"
  | Application_Insights -> "Amazon CloudWatch Application Insights"
  | Alexa_For_Business -> "Alexa For Business"
  | RoboMaker -> "AWS RoboMaker"
  | EventBridge -> "Amazon EventBridge"
  | Auto_Scaling -> "Auto Scaling"
  | Elastic_Load_Balancing_v2 -> "Elastic Load Balancing"
  | Greengrass -> "AWS Greengrass"
  | SecurityHub -> "AWS SecurityHub"
  | Backup -> "AWS Backup"
  | CloudFormation -> "AWS CloudFormation"
  | Kendra -> "AWSKendraFrontendService"
  | Connect -> "Amazon Connect Service"
  | ElastiCache -> "Amazon ElastiCache"
  | Cost_Explorer -> "AWS Cost Explorer Service"
  | Comprehend -> "Amazon Comprehend"
  | Device_Farm -> "AWS Device Farm"
  | RDS_Data -> "AWS RDS DataService"
  | Rekognition -> "Amazon Rekognition"
  | AppStream -> "Amazon AppStream"
  | Polly -> "Amazon Polly"
  | RDS -> "Amazon Relational Database Service"
  | Pricing -> "AWS Price List Service"
  | SWF -> "Amazon Simple Workflow Service"
  | QLDB_Session -> "Amazon QLDB Session"
  | Data_Pipeline -> "AWS Data Pipeline"
  | Transcribe -> "Amazon Transcribe Service"
  | SFN -> "AWS Step Functions"
  | CodeCommit -> "AWS CodeCommit"
  | Resource_Groups_Tagging_API -> "AWS Resource Groups Tagging API"
  | Forecastquery -> "Amazon Forecast Query Service"
  | Marketplace_Catalog -> "AWS Marketplace Catalog Service"
  | ApiGatewayManagementApi -> "AmazonApiGatewayManagementApi"
  | XRay -> "AWS X-Ray"
  | API_Gateway -> "Amazon API Gateway"
  | RAM -> "AWS Resource Access Manager"
  | EFS -> "Amazon Elastic File System"
  | Cognito_Identity -> "Amazon Cognito Identity"
  | DataExchange -> "AWS Data Exchange"
  | STS -> "AWS Security Token Service"
  | SageMaker -> "Amazon SageMaker Service"
  | Kinesis_Video_Archived_Media ->
      "Amazon Kinesis Video Streams Archived Media"
  | ACM -> "AWS Certificate Manager"
  | Athena -> "Amazon Athena"
  | Route_53 -> "Amazon Route 53"
  | IoT_Jobs_Data_Plane -> "AWS IoT Jobs Data Plane"
  | MediaPackage_Vod -> "AWS Elemental MediaPackage VOD"
  | EC2 -> "Amazon Elastic Compute Cloud"
let pp_hum formatter svc = Format.fprintf formatter "%s" (full_name svc)