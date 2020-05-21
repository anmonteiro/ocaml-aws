open Aws
open Aws.BaseTypes
module ResourceRecord =
  struct
    type t =
      {
      value: String.t
        [@ocaml.doc
          "<p>The current or new DNS record value, not to exceed 4,000 characters. In the case of a <code>DELETE</code> action, if the current value does not match the actual value, an error is returned. For descriptions about how to format <code>Value</code> for different record types, see <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/ResourceRecordTypes.html\">Supported DNS Resource Record Types</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>You can specify more than one value for all record types except <code>CNAME</code> and <code>SOA</code>. </p> <note> <p>If you're creating an alias resource record set, omit <code>Value</code>.</p> </note>"]}
    [@@ocaml.doc
      "<p>Information specific to the resource record.</p> <note> <p>If you're creating an alias resource record set, omit <code>ResourceRecord</code>.</p> </note>"]
    let make ~value  () = { value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("value", (String.to_json v.value))])
    let parse xml =
      Some
        {
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
  end[@@ocaml.doc
       "<p>Information specific to the resource record.</p> <note> <p>If you're creating an alias resource record set, omit <code>ResourceRecord</code>.</p> </note>"]
module Dimension =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>For the metric that the CloudWatch alarm is associated with, the name of one dimension.</p>"];
      value: String.t
        [@ocaml.doc
          "<p>For the metric that the CloudWatch alarm is associated with, the value of one dimension.</p>"]}
    [@@ocaml.doc
      "<p>For the metric that the CloudWatch alarm is associated with, a complex type that contains information about one dimension.</p>"]
    let make ~name  ~value  () = { name; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
           @ [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
  end[@@ocaml.doc
       "<p>For the metric that the CloudWatch alarm is associated with, a complex type that contains information about one dimension.</p>"]
module CloudWatchRegion =
  struct
    type t =
      | Us_east_1 
      | Us_east_2 
      | Us_west_1 
      | Us_west_2 
      | Ca_central_1 
      | Eu_central_1 
      | Eu_west_1 
      | Eu_west_2 
      | Eu_west_3 
      | Ap_east_1 
      | Me_south_1 
      | Ap_south_1 
      | Ap_southeast_1 
      | Ap_southeast_2 
      | Ap_northeast_1 
      | Ap_northeast_2 
      | Ap_northeast_3 
      | Eu_north_1 
      | Sa_east_1 
      | Cn_northwest_1 
      | Cn_north_1 
    let str_to_t =
      [("cn-north-1", Cn_north_1);
      ("cn-northwest-1", Cn_northwest_1);
      ("sa-east-1", Sa_east_1);
      ("eu-north-1", Eu_north_1);
      ("ap-northeast-3", Ap_northeast_3);
      ("ap-northeast-2", Ap_northeast_2);
      ("ap-northeast-1", Ap_northeast_1);
      ("ap-southeast-2", Ap_southeast_2);
      ("ap-southeast-1", Ap_southeast_1);
      ("ap-south-1", Ap_south_1);
      ("me-south-1", Me_south_1);
      ("ap-east-1", Ap_east_1);
      ("eu-west-3", Eu_west_3);
      ("eu-west-2", Eu_west_2);
      ("eu-west-1", Eu_west_1);
      ("eu-central-1", Eu_central_1);
      ("ca-central-1", Ca_central_1);
      ("us-west-2", Us_west_2);
      ("us-west-1", Us_west_1);
      ("us-east-2", Us_east_2);
      ("us-east-1", Us_east_1)]
    let t_to_str =
      [(Cn_north_1, "cn-north-1");
      (Cn_northwest_1, "cn-northwest-1");
      (Sa_east_1, "sa-east-1");
      (Eu_north_1, "eu-north-1");
      (Ap_northeast_3, "ap-northeast-3");
      (Ap_northeast_2, "ap-northeast-2");
      (Ap_northeast_1, "ap-northeast-1");
      (Ap_southeast_2, "ap-southeast-2");
      (Ap_southeast_1, "ap-southeast-1");
      (Ap_south_1, "ap-south-1");
      (Me_south_1, "me-south-1");
      (Ap_east_1, "ap-east-1");
      (Eu_west_3, "eu-west-3");
      (Eu_west_2, "eu-west-2");
      (Eu_west_1, "eu-west-1");
      (Eu_central_1, "eu-central-1");
      (Ca_central_1, "ca-central-1");
      (Us_west_2, "us-west-2");
      (Us_west_1, "us-west-1");
      (Us_east_2, "us-east-2");
      (Us_east_1, "us-east-1")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module HealthCheckRegion =
  struct
    type t =
      | Us_east_1 
      | Us_west_1 
      | Us_west_2 
      | Eu_west_1 
      | Ap_southeast_1 
      | Ap_southeast_2 
      | Ap_northeast_1 
      | Sa_east_1 
    let str_to_t =
      [("sa-east-1", Sa_east_1);
      ("ap-northeast-1", Ap_northeast_1);
      ("ap-southeast-2", Ap_southeast_2);
      ("ap-southeast-1", Ap_southeast_1);
      ("eu-west-1", Eu_west_1);
      ("us-west-2", Us_west_2);
      ("us-west-1", Us_west_1);
      ("us-east-1", Us_east_1)]
    let t_to_str =
      [(Sa_east_1, "sa-east-1");
      (Ap_northeast_1, "ap-northeast-1");
      (Ap_southeast_2, "ap-southeast-2");
      (Ap_southeast_1, "ap-southeast-1");
      (Eu_west_1, "eu-west-1");
      (Us_west_2, "us-west-2");
      (Us_west_1, "us-west-1");
      (Us_east_1, "us-east-1")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module AliasTarget =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p> <i>Alias resource records sets only</i>: The value used depends on where you want to route traffic:</p> <dl> <dt>Amazon API Gateway custom regional APIs and edge-optimized APIs</dt> <dd> <p>Specify the hosted zone ID for your API. You can get the applicable value using the AWS CLI command <a href=\"https://docs.aws.amazon.com/cli/latest/reference/apigateway/get-domain-names.html\">get-domain-names</a>:</p> <ul> <li> <p>For regional APIs, specify the value of <code>regionalHostedZoneId</code>.</p> </li> <li> <p>For edge-optimized APIs, specify the value of <code>distributionHostedZoneId</code>.</p> </li> </ul> </dd> <dt>Amazon Virtual Private Cloud interface VPC endpoint</dt> <dd> <p>Specify the hosted zone ID for your interface endpoint. You can get the value of <code>HostedZoneId</code> using the AWS CLI command <a href=\"https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-vpc-endpoints.html\">describe-vpc-endpoints</a>.</p> </dd> <dt>CloudFront distribution</dt> <dd> <p>Specify <code>Z2FDTNDATAQYW2</code>.</p> <note> <p>Alias resource record sets for CloudFront can't be created in a private zone.</p> </note> </dd> <dt>Elastic Beanstalk environment</dt> <dd> <p>Specify the hosted zone ID for the region that you created the environment in. The environment must have a regionalized subdomain. For a list of regions and the corresponding hosted zone IDs, see <a href=\"http://docs.aws.amazon.com/general/latest/gr/rande.html#elasticbeanstalk_region\">AWS Elastic Beanstalk</a> in the \"AWS Regions and Endpoints\" chapter of the <i>Amazon Web Services General Reference</i>.</p> </dd> <dt>ELB load balancer</dt> <dd> <p>Specify the value of the hosted zone ID for the load balancer. Use the following methods to get the hosted zone ID:</p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/general/latest/gr/rande.html#elb_region\">Elastic Load Balancing</a> table in the \"AWS Regions and Endpoints\" chapter of the <i>Amazon Web Services General Reference</i>: Use the value that corresponds with the region that you created your load balancer in. Note that there are separate columns for Application and Classic Load Balancers and for Network Load Balancers.</p> </li> <li> <p> <b>AWS Management Console</b>: Go to the Amazon EC2 page, choose <b>Load Balancers</b> in the navigation pane, select the load balancer, and get the value of the <b>Hosted zone</b> field on the <b>Description</b> tab.</p> </li> <li> <p> <b>Elastic Load Balancing API</b>: Use <code>DescribeLoadBalancers</code> to get the applicable value. For more information, see the applicable guide:</p> <ul> <li> <p>Classic Load Balancers: Use <a href=\"http://docs.aws.amazon.com/elasticloadbalancing/2012-06-01/APIReference/API_DescribeLoadBalancers.html\">DescribeLoadBalancers</a> to get the value of <code>CanonicalHostedZoneNameId</code>.</p> </li> <li> <p>Application and Network Load Balancers: Use <a href=\"http://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeLoadBalancers.html\">DescribeLoadBalancers</a> to get the value of <code>CanonicalHostedZoneId</code>.</p> </li> </ul> </li> <li> <p> <b>AWS CLI</b>: Use <code>describe-load-balancers</code> to get the applicable value. For more information, see the applicable guide:</p> <ul> <li> <p>Classic Load Balancers: Use <a href=\"http://docs.aws.amazon.com/cli/latest/reference/elb/describe-load-balancers.html\">describe-load-balancers</a> to get the value of <code>CanonicalHostedZoneNameId</code>.</p> </li> <li> <p>Application and Network Load Balancers: Use <a href=\"http://docs.aws.amazon.com/cli/latest/reference/elbv2/describe-load-balancers.html\">describe-load-balancers</a> to get the value of <code>CanonicalHostedZoneId</code>.</p> </li> </ul> </li> </ul> </dd> <dt>An Amazon S3 bucket configured as a static website</dt> <dd> <p>Specify the hosted zone ID for the region that you created the bucket in. For more information about valid values, see the <a href=\"http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\">Amazon Simple Storage Service Website Endpoints</a> table in the \"AWS Regions and Endpoints\" chapter of the <i>Amazon Web Services General Reference</i>.</p> </dd> <dt>Another Route 53 resource record set in your hosted zone</dt> <dd> <p>Specify the hosted zone ID of your hosted zone. (An alias resource record set can't reference a resource record set in a different hosted zone.)</p> </dd> </dl>"];
      d_n_s_name: String.t
        [@ocaml.doc
          "<p> <i>Alias resource record sets only:</i> The value that you specify depends on where you want to route queries:</p> <dl> <dt>Amazon API Gateway custom regional APIs and edge-optimized APIs</dt> <dd> <p>Specify the applicable domain name for your API. You can get the applicable value using the AWS CLI command <a href=\"https://docs.aws.amazon.com/cli/latest/reference/apigateway/get-domain-names.html\">get-domain-names</a>:</p> <ul> <li> <p>For regional APIs, specify the value of <code>regionalDomainName</code>.</p> </li> <li> <p>For edge-optimized APIs, specify the value of <code>distributionDomainName</code>. This is the name of the associated CloudFront distribution, such as <code>da1b2c3d4e5.cloudfront.net</code>.</p> </li> </ul> <note> <p>The name of the record that you're creating must match a custom domain name for your API, such as <code>api.example.com</code>.</p> </note> </dd> <dt>Amazon Virtual Private Cloud interface VPC endpoint</dt> <dd> <p>Enter the API endpoint for the interface endpoint, such as <code>vpce-123456789abcdef01-example-us-east-1a.elasticloadbalancing.us-east-1.vpce.amazonaws.com</code>. For edge-optimized APIs, this is the domain name for the corresponding CloudFront distribution. You can get the value of <code>DnsName</code> using the AWS CLI command <a href=\"https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-vpc-endpoints.html\">describe-vpc-endpoints</a>.</p> </dd> <dt>CloudFront distribution</dt> <dd> <p>Specify the domain name that CloudFront assigned when you created your distribution.</p> <p>Your CloudFront distribution must include an alternate domain name that matches the name of the resource record set. For example, if the name of the resource record set is <i>acme.example.com</i>, your CloudFront distribution must include <i>acme.example.com</i> as one of the alternate domain names. For more information, see <a href=\"http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/CNAMEs.html\">Using Alternate Domain Names (CNAMEs)</a> in the <i>Amazon CloudFront Developer Guide</i>.</p> <p>You can't create a resource record set in a private hosted zone to route traffic to a CloudFront distribution.</p> <note> <p>For failover alias records, you can't specify a CloudFront distribution for both the primary and secondary records. A distribution must include an alternate domain name that matches the name of the record. However, the primary and secondary records have the same name, and you can't include the same alternate domain name in more than one distribution. </p> </note> </dd> <dt>Elastic Beanstalk environment</dt> <dd> <p>If the domain name for your Elastic Beanstalk environment includes the region that you deployed the environment in, you can create an alias record that routes traffic to the environment. For example, the domain name <code>my-environment.<i>us-west-2</i>.elasticbeanstalk.com</code> is a regionalized domain name. </p> <important> <p>For environments that were created before early 2016, the domain name doesn't include the region. To route traffic to these environments, you must create a CNAME record instead of an alias record. Note that you can't create a CNAME record for the root domain name. For example, if your domain name is example.com, you can create a record that routes traffic for acme.example.com to your Elastic Beanstalk environment, but you can't create a record that routes traffic for example.com to your Elastic Beanstalk environment.</p> </important> <p>For Elastic Beanstalk environments that have regionalized subdomains, specify the <code>CNAME</code> attribute for the environment. You can use the following methods to get the value of the CNAME attribute:</p> <ul> <li> <p> <i>AWS Management Console</i>: For information about how to get the value by using the console, see <a href=\"http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/customdomains.html\">Using Custom Domains with AWS Elastic Beanstalk</a> in the <i>AWS Elastic Beanstalk Developer Guide</i>.</p> </li> <li> <p> <i>Elastic Beanstalk API</i>: Use the <code>DescribeEnvironments</code> action to get the value of the <code>CNAME</code> attribute. For more information, see <a href=\"http://docs.aws.amazon.com/elasticbeanstalk/latest/api/API_DescribeEnvironments.html\">DescribeEnvironments</a> in the <i>AWS Elastic Beanstalk API Reference</i>.</p> </li> <li> <p> <i>AWS CLI</i>: Use the <code>describe-environments</code> command to get the value of the <code>CNAME</code> attribute. For more information, see <a href=\"http://docs.aws.amazon.com/cli/latest/reference/elasticbeanstalk/describe-environments.html\">describe-environments</a> in the <i>AWS Command Line Interface Reference</i>.</p> </li> </ul> </dd> <dt>ELB load balancer</dt> <dd> <p>Specify the DNS name that is associated with the load balancer. Get the DNS name by using the AWS Management Console, the ELB API, or the AWS CLI. </p> <ul> <li> <p> <b>AWS Management Console</b>: Go to the EC2 page, choose <b>Load Balancers</b> in the navigation pane, choose the load balancer, choose the <b>Description</b> tab, and get the value of the <b>DNS name</b> field. </p> <p>If you're routing traffic to a Classic Load Balancer, get the value that begins with <b>dualstack</b>. If you're routing traffic to another type of load balancer, get the value that applies to the record type, A or AAAA.</p> </li> <li> <p> <b>Elastic Load Balancing API</b>: Use <code>DescribeLoadBalancers</code> to get the value of <code>DNSName</code>. For more information, see the applicable guide:</p> <ul> <li> <p>Classic Load Balancers: <a href=\"http://docs.aws.amazon.com/elasticloadbalancing/2012-06-01/APIReference/API_DescribeLoadBalancers.html\">DescribeLoadBalancers</a> </p> </li> <li> <p>Application and Network Load Balancers: <a href=\"http://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_DescribeLoadBalancers.html\">DescribeLoadBalancers</a> </p> </li> </ul> </li> <li> <p> <b>AWS CLI</b>: Use <code>describe-load-balancers</code> to get the value of <code>DNSName</code>. For more information, see the applicable guide:</p> <ul> <li> <p>Classic Load Balancers: <a href=\"http://docs.aws.amazon.com/cli/latest/reference/elb/describe-load-balancers.html\">describe-load-balancers</a> </p> </li> <li> <p>Application and Network Load Balancers: <a href=\"http://docs.aws.amazon.com/cli/latest/reference/elbv2/describe-load-balancers.html\">describe-load-balancers</a> </p> </li> </ul> </li> </ul> </dd> <dt>Amazon S3 bucket that is configured as a static website</dt> <dd> <p>Specify the domain name of the Amazon S3 website endpoint that you created the bucket in, for example, <code>s3-website.us-east-2.amazonaws.com</code>. For more information about valid values, see the table <a href=\"http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region\">Amazon Simple Storage Service (S3) Website Endpoints</a> in the <i>Amazon Web Services General Reference</i>. For more information about using S3 buckets for websites, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/getting-started.html\">Getting Started with Amazon Route 53</a> in the <i>Amazon Route 53 Developer Guide.</i> </p> </dd> <dt>Another Route 53 resource record set</dt> <dd> <p>Specify the value of the <code>Name</code> element for a resource record set in the current hosted zone.</p> <note> <p>If you're creating an alias record that has the same name as the hosted zone (known as the zone apex), you can't specify the domain name for a record for which the value of <code>Type</code> is <code>CNAME</code>. This is because the alias record must have the same type as the record that you're routing traffic to, and creating a CNAME record for the zone apex isn't supported even for an alias record.</p> </note> </dd> </dl>"];
      evaluate_target_health: Boolean.t
        [@ocaml.doc
          "<p> <i>Applies only to alias, failover alias, geolocation alias, latency alias, and weighted alias resource record sets:</i> When <code>EvaluateTargetHealth</code> is <code>true</code>, an alias resource record set inherits the health of the referenced AWS resource, such as an ELB load balancer or another resource record set in the hosted zone.</p> <p>Note the following:</p> <dl> <dt>CloudFront distributions</dt> <dd> <p>You can't set <code>EvaluateTargetHealth</code> to <code>true</code> when the alias target is a CloudFront distribution.</p> </dd> <dt>Elastic Beanstalk environments that have regionalized subdomains</dt> <dd> <p>If you specify an Elastic Beanstalk environment in <code>DNSName</code> and the environment contains an ELB load balancer, Elastic Load Balancing routes queries only to the healthy Amazon EC2 instances that are registered with the load balancer. (An environment automatically contains an ELB load balancer if it includes more than one Amazon EC2 instance.) If you set <code>EvaluateTargetHealth</code> to <code>true</code> and either no Amazon EC2 instances are healthy or the load balancer itself is unhealthy, Route 53 routes queries to other available resources that are healthy, if any. </p> <p>If the environment contains a single Amazon EC2 instance, there are no special requirements.</p> </dd> <dt>ELB load balancers</dt> <dd> <p>Health checking behavior depends on the type of load balancer:</p> <ul> <li> <p> <b>Classic Load Balancers</b>: If you specify an ELB Classic Load Balancer in <code>DNSName</code>, Elastic Load Balancing routes queries only to the healthy Amazon EC2 instances that are registered with the load balancer. If you set <code>EvaluateTargetHealth</code> to <code>true</code> and either no EC2 instances are healthy or the load balancer itself is unhealthy, Route 53 routes queries to other resources.</p> </li> <li> <p> <b>Application and Network Load Balancers</b>: If you specify an ELB Application or Network Load Balancer and you set <code>EvaluateTargetHealth</code> to <code>true</code>, Route 53 routes queries to the load balancer based on the health of the target groups that are associated with the load balancer:</p> <ul> <li> <p>For an Application or Network Load Balancer to be considered healthy, every target group that contains targets must contain at least one healthy target. If any target group contains only unhealthy targets, the load balancer is considered unhealthy, and Route 53 routes queries to other resources.</p> </li> <li> <p>A target group that has no registered targets is considered unhealthy.</p> </li> </ul> </li> </ul> <note> <p>When you create a load balancer, you configure settings for Elastic Load Balancing health checks; they're not Route 53 health checks, but they perform a similar function. Do not create Route 53 health checks for the EC2 instances that you register with an ELB load balancer. </p> </note> </dd> <dt>S3 buckets</dt> <dd> <p>There are no special requirements for setting <code>EvaluateTargetHealth</code> to <code>true</code> when the alias target is an S3 bucket.</p> </dd> <dt>Other records in the same hosted zone</dt> <dd> <p>If the AWS resource that you specify in <code>DNSName</code> is a record or a group of records (for example, a group of weighted records) but is not another alias record, we recommend that you associate a health check with all of the records in the alias target. For more information, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-complex-configs.html#dns-failover-complex-configs-hc-omitting\">What Happens When You Omit Health Checks?</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> </dd> </dl> <p>For more information and examples, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover.html\">Amazon Route 53 Health Checks and DNS Failover</a> in the <i>Amazon Route 53 Developer Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p> <i>Alias resource record sets only:</i> Information about the AWS resource, such as a CloudFront distribution or an Amazon S3 bucket, that you want to route traffic to.</p> <p>When creating resource record sets for a private hosted zone, note the following:</p> <ul> <li> <p>Creating geolocation alias resource record sets or latency alias resource record sets in a private hosted zone is unsupported.</p> </li> <li> <p>For information about creating failover resource record sets in a private hosted zone, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-private-hosted-zones.html\">Configuring Failover in a Private Hosted Zone</a>.</p> </li> </ul>"]
    let make ~hosted_zone_id  ~d_n_s_name  ~evaluate_target_health  () =
      { hosted_zone_id; d_n_s_name; evaluate_target_health }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("evaluate_target_health",
                (Boolean.to_json v.evaluate_target_health));
           Some ("d_n_s_name", (String.to_json v.d_n_s_name));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "HostedZoneId"
               (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse));
          d_n_s_name =
            (Xml.required "DNSName"
               (Util.option_bind (Xml.member "DNSName" xml) String.parse));
          evaluate_target_health =
            (Xml.required "EvaluateTargetHealth"
               (Util.option_bind (Xml.member "EvaluateTargetHealth" xml)
                  Boolean.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "HostedZoneId"
                   ([], (String.to_xml v.hosted_zone_id)))])
            @
            [Some
               (Ezxmlm.make_tag "DNSName" ([], (String.to_xml v.d_n_s_name)))])
           @
           [Some
              (Ezxmlm.make_tag "EvaluateTargetHealth"
                 ([], (Boolean.to_xml v.evaluate_target_health)))])
  end[@@ocaml.doc
       "<p> <i>Alias resource record sets only:</i> Information about the AWS resource, such as a CloudFront distribution or an Amazon S3 bucket, that you want to route traffic to.</p> <p>When creating resource record sets for a private hosted zone, note the following:</p> <ul> <li> <p>Creating geolocation alias resource record sets or latency alias resource record sets in a private hosted zone is unsupported.</p> </li> <li> <p>For information about creating failover resource record sets in a private hosted zone, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-private-hosted-zones.html\">Configuring Failover in a Private Hosted Zone</a>.</p> </li> </ul>"]
module GeoLocation =
  struct
    type t =
      {
      continent_code: String.t option
        [@ocaml.doc
          "<p>The two-letter code for the continent.</p> <p>Valid values: <code>AF</code> | <code>AN</code> | <code>AS</code> | <code>EU</code> | <code>OC</code> | <code>NA</code> | <code>SA</code> </p> <p>Constraint: Specifying <code>ContinentCode</code> with either <code>CountryCode</code> or <code>SubdivisionCode</code> returns an <code>InvalidInput</code> error.</p>"];
      country_code: String.t option
        [@ocaml.doc "<p>The two-letter code for the country.</p>"];
      subdivision_code: String.t option
        [@ocaml.doc
          "<p>The code for the subdivision. Route 53 currently supports only states in the United States.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about a geographic location.</p>"]
    let make ?continent_code  ?country_code  ?subdivision_code  () =
      { continent_code; country_code; subdivision_code }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.subdivision_code
              (fun f -> ("subdivision_code", (String.to_json f)));
           Util.option_map v.country_code
             (fun f -> ("country_code", (String.to_json f)));
           Util.option_map v.continent_code
             (fun f -> ("continent_code", (String.to_json f)))])
    let parse xml =
      Some
        {
          continent_code =
            (Util.option_bind (Xml.member "ContinentCode" xml) String.parse);
          country_code =
            (Util.option_bind (Xml.member "CountryCode" xml) String.parse);
          subdivision_code =
            (Util.option_bind (Xml.member "SubdivisionCode" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.continent_code
                (fun f ->
                   Ezxmlm.make_tag "ContinentCode" ([], (String.to_xml f)))])
            @
            [Util.option_map v.country_code
               (fun f ->
                  Ezxmlm.make_tag "CountryCode" ([], (String.to_xml f)))])
           @
           [Util.option_map v.subdivision_code
              (fun f ->
                 Ezxmlm.make_tag "SubdivisionCode" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about a geographic location.</p>"]
module RRType =
  struct
    type t =
      | SOA 
      | A 
      | TXT 
      | NS 
      | CNAME 
      | MX 
      | NAPTR 
      | PTR 
      | SRV 
      | SPF 
      | AAAA 
      | CAA 
    let str_to_t =
      [("CAA", CAA);
      ("AAAA", AAAA);
      ("SPF", SPF);
      ("SRV", SRV);
      ("PTR", PTR);
      ("NAPTR", NAPTR);
      ("MX", MX);
      ("CNAME", CNAME);
      ("NS", NS);
      ("TXT", TXT);
      ("A", A);
      ("SOA", SOA)]
    let t_to_str =
      [(CAA, "CAA");
      (AAAA, "AAAA");
      (SPF, "SPF");
      (SRV, "SRV");
      (PTR, "PTR");
      (NAPTR, "NAPTR");
      (MX, "MX");
      (CNAME, "CNAME");
      (NS, "NS");
      (TXT, "TXT");
      (A, "A");
      (SOA, "SOA")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ResourceRecordSetFailover =
  struct
    type t =
      | PRIMARY 
      | SECONDARY 
    let str_to_t = [("SECONDARY", SECONDARY); ("PRIMARY", PRIMARY)]
    let t_to_str = [(SECONDARY, "SECONDARY"); (PRIMARY, "PRIMARY")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ResourceRecordSetRegion =
  struct
    type t =
      | Us_east_1 
      | Us_east_2 
      | Us_west_1 
      | Us_west_2 
      | Ca_central_1 
      | Eu_west_1 
      | Eu_west_2 
      | Eu_west_3 
      | Eu_central_1 
      | Ap_southeast_1 
      | Ap_southeast_2 
      | Ap_northeast_1 
      | Ap_northeast_2 
      | Ap_northeast_3 
      | Eu_north_1 
      | Sa_east_1 
      | Cn_north_1 
      | Cn_northwest_1 
      | Ap_east_1 
      | Me_south_1 
      | Ap_south_1 
    let str_to_t =
      [("ap-south-1", Ap_south_1);
      ("me-south-1", Me_south_1);
      ("ap-east-1", Ap_east_1);
      ("cn-northwest-1", Cn_northwest_1);
      ("cn-north-1", Cn_north_1);
      ("sa-east-1", Sa_east_1);
      ("eu-north-1", Eu_north_1);
      ("ap-northeast-3", Ap_northeast_3);
      ("ap-northeast-2", Ap_northeast_2);
      ("ap-northeast-1", Ap_northeast_1);
      ("ap-southeast-2", Ap_southeast_2);
      ("ap-southeast-1", Ap_southeast_1);
      ("eu-central-1", Eu_central_1);
      ("eu-west-3", Eu_west_3);
      ("eu-west-2", Eu_west_2);
      ("eu-west-1", Eu_west_1);
      ("ca-central-1", Ca_central_1);
      ("us-west-2", Us_west_2);
      ("us-west-1", Us_west_1);
      ("us-east-2", Us_east_2);
      ("us-east-1", Us_east_1)]
    let t_to_str =
      [(Ap_south_1, "ap-south-1");
      (Me_south_1, "me-south-1");
      (Ap_east_1, "ap-east-1");
      (Cn_northwest_1, "cn-northwest-1");
      (Cn_north_1, "cn-north-1");
      (Sa_east_1, "sa-east-1");
      (Eu_north_1, "eu-north-1");
      (Ap_northeast_3, "ap-northeast-3");
      (Ap_northeast_2, "ap-northeast-2");
      (Ap_northeast_1, "ap-northeast-1");
      (Ap_southeast_2, "ap-southeast-2");
      (Ap_southeast_1, "ap-southeast-1");
      (Eu_central_1, "eu-central-1");
      (Eu_west_3, "eu-west-3");
      (Eu_west_2, "eu-west-2");
      (Eu_west_1, "eu-west-1");
      (Ca_central_1, "ca-central-1");
      (Us_west_2, "us-west-2");
      (Us_west_1, "us-west-1");
      (Us_east_2, "us-east-2");
      (Us_east_1, "us-east-1")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ResourceRecords =
  struct
    type t = ResourceRecord.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResourceRecord.to_query v
    let to_headers v = Headers.to_headers_list ResourceRecord.to_headers v
    let to_json v = `List (List.map ResourceRecord.to_json v)
    let parse xml =
      Util.option_all
        (List.map ResourceRecord.parse (Xml.members "ResourceRecord" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ResourceRecord.to_xml x))) v
  end
module ComparisonOperator =
  struct
    type t =
      | GreaterThanOrEqualToThreshold 
      | GreaterThanThreshold 
      | LessThanThreshold 
      | LessThanOrEqualToThreshold 
    let str_to_t =
      [("LessThanOrEqualToThreshold", LessThanOrEqualToThreshold);
      ("LessThanThreshold", LessThanThreshold);
      ("GreaterThanThreshold", GreaterThanThreshold);
      ("GreaterThanOrEqualToThreshold", GreaterThanOrEqualToThreshold)]
    let t_to_str =
      [(LessThanOrEqualToThreshold, "LessThanOrEqualToThreshold");
      (LessThanThreshold, "LessThanThreshold");
      (GreaterThanThreshold, "GreaterThanThreshold");
      (GreaterThanOrEqualToThreshold, "GreaterThanOrEqualToThreshold")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module DimensionList =
  struct
    type t = Dimension.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Dimension.to_query v
    let to_headers v = Headers.to_headers_list Dimension.to_headers v
    let to_json v = `List (List.map Dimension.to_json v)
    let parse xml =
      Util.option_all
        (List.map Dimension.parse (Xml.members "Dimension" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Dimension.to_xml x)))
        v
  end
module Statistic =
  struct
    type t =
      | Average 
      | Sum 
      | SampleCount 
      | Maximum 
      | Minimum 
    let str_to_t =
      [("Minimum", Minimum);
      ("Maximum", Maximum);
      ("SampleCount", SampleCount);
      ("Sum", Sum);
      ("Average", Average)]
    let t_to_str =
      [(Minimum, "Minimum");
      (Maximum, "Maximum");
      (SampleCount, "SampleCount");
      (Sum, "Sum");
      (Average, "Average")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module AlarmIdentifier =
  struct
    type t =
      {
      region: CloudWatchRegion.t
        [@ocaml.doc
          "<p>For the CloudWatch alarm that you want Route 53 health checkers to use to determine whether this health check is healthy, the region that the alarm was created in.</p> <p>For the current list of CloudWatch regions, see <a href=\"http://docs.aws.amazon.com/general/latest/gr/rande.html#cw_region\">Amazon CloudWatch</a> in the <i>AWS Regions and Endpoints</i> chapter of the <i>Amazon Web Services General Reference</i>.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>The name of the CloudWatch alarm that you want Amazon Route 53 health checkers to use to determine whether this health check is healthy.</p> <note> <p>Route 53 supports CloudWatch alarms with the following features:</p> <ul> <li> <p>Standard-resolution metrics. High-resolution metrics aren't supported. For more information, see <a href=\"http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/publishingMetrics.html#high-resolution-metrics\">High-Resolution Metrics</a> in the <i>Amazon CloudWatch User Guide</i>.</p> </li> <li> <p>Statistics: Average, Minimum, Maximum, Sum, and SampleCount. Extended statistics aren't supported.</p> </li> </ul> </note>"]}
    [@@ocaml.doc
      "<p>A complex type that identifies the CloudWatch alarm that you want Amazon Route 53 health checkers to use to determine whether the specified health check is healthy.</p>"]
    let make ~region  ~name  () = { region; name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("name", (String.to_json v.name));
           Some ("region", (CloudWatchRegion.to_json v.region))])
    let parse xml =
      Some
        {
          region =
            (Xml.required "Region"
               (Util.option_bind (Xml.member "Region" xml)
                  CloudWatchRegion.parse));
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Region"
                  ([], (CloudWatchRegion.to_xml v.region)))])
           @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
  end[@@ocaml.doc
       "<p>A complex type that identifies the CloudWatch alarm that you want Amazon Route 53 health checkers to use to determine whether the specified health check is healthy.</p>"]
module ChildHealthCheckList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "ChildHealthCheck" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module HealthCheckRegionList =
  struct
    type t = HealthCheckRegion.t list
    let make elems () = elems
    let to_query v = Query.to_query_list HealthCheckRegion.to_query v
    let to_headers v = Headers.to_headers_list HealthCheckRegion.to_headers v
    let to_json v = `List (List.map HealthCheckRegion.to_json v)
    let parse xml =
      Util.option_all
        (List.map HealthCheckRegion.parse (Xml.members "Region" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (HealthCheckRegion.to_xml x)))
        v
  end
module HealthCheckType =
  struct
    type t =
      | HTTP 
      | HTTPS 
      | HTTP_STR_MATCH 
      | HTTPS_STR_MATCH 
      | TCP 
      | CALCULATED 
      | CLOUDWATCH_METRIC 
    let str_to_t =
      [("CLOUDWATCH_METRIC", CLOUDWATCH_METRIC);
      ("CALCULATED", CALCULATED);
      ("TCP", TCP);
      ("HTTPS_STR_MATCH", HTTPS_STR_MATCH);
      ("HTTP_STR_MATCH", HTTP_STR_MATCH);
      ("HTTPS", HTTPS);
      ("HTTP", HTTP)]
    let t_to_str =
      [(CLOUDWATCH_METRIC, "CLOUDWATCH_METRIC");
      (CALCULATED, "CALCULATED");
      (TCP, "TCP");
      (HTTPS_STR_MATCH, "HTTPS_STR_MATCH");
      (HTTP_STR_MATCH, "HTTP_STR_MATCH");
      (HTTPS, "HTTPS");
      (HTTP, "HTTP")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module InsufficientDataHealthStatus =
  struct
    type t =
      | Healthy 
      | Unhealthy 
      | LastKnownStatus 
    let str_to_t =
      [("LastKnownStatus", LastKnownStatus);
      ("Unhealthy", Unhealthy);
      ("Healthy", Healthy)]
    let t_to_str =
      [(LastKnownStatus, "LastKnownStatus");
      (Unhealthy, "Unhealthy");
      (Healthy, "Healthy")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module Tag =
  struct
    type t =
      {
      key: String.t option
        [@ocaml.doc
          "<p>The value of <code>Key</code> depends on the operation that you want to perform:</p> <ul> <li> <p> <b>Add a tag to a health check or hosted zone</b>: <code>Key</code> is the name that you want to give the new tag.</p> </li> <li> <p> <b>Edit a tag</b>: <code>Key</code> is the name of the tag that you want to change the <code>Value</code> for.</p> </li> <li> <p> <b> Delete a key</b>: <code>Key</code> is the name of the tag you want to remove.</p> </li> <li> <p> <b>Give a name to a health check</b>: Edit the default <code>Name</code> tag. In the Amazon Route 53 console, the list of your health checks includes a <b>Name</b> column that lets you see the name that you've given to each health check.</p> </li> </ul>"];
      value: String.t option
        [@ocaml.doc
          "<p>The value of <code>Value</code> depends on the operation that you want to perform:</p> <ul> <li> <p> <b>Add a tag to a health check or hosted zone</b>: <code>Value</code> is the value that you want to give the new tag.</p> </li> <li> <p> <b>Edit a tag</b>: <code>Value</code> is the new value that you want to assign the tag.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about a tag that you want to add or edit for the specified health check or hosted zone.</p>"]
    let make ?key  ?value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let parse xml =
      Some
        {
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.key
               (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about a tag that you want to add or edit for the specified health check or hosted zone.</p>"]
module ChangeAction =
  struct
    type t =
      | CREATE 
      | DELETE 
      | UPSERT 
    let str_to_t =
      [("UPSERT", UPSERT); ("DELETE", DELETE); ("CREATE", CREATE)]
    let t_to_str =
      [(UPSERT, "UPSERT"); (DELETE, "DELETE"); (CREATE, "CREATE")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ResourceRecordSet =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>For <code>ChangeResourceRecordSets</code> requests, the name of the record that you want to create, update, or delete. For <code>ListResourceRecordSets</code> responses, the name of a record in the specified hosted zone.</p> <p> <b>ChangeResourceRecordSets Only</b> </p> <p>Enter a fully qualified domain name, for example, <code>www.example.com</code>. You can optionally include a trailing dot. If you omit the trailing dot, Amazon Route 53 assumes that the domain name that you specify is fully qualified. This means that Route 53 treats <code>www.example.com</code> (without a trailing dot) and <code>www.example.com.</code> (with a trailing dot) as identical.</p> <p>For information about how to specify characters other than <code>a-z</code>, <code>0-9</code>, and <code>-</code> (hyphen) and how to specify internationalized domain names, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DomainNameFormat.html\">DNS Domain Name Format</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>You can use the asterisk (*) wildcard to replace the leftmost label in a domain name, for example, <code>*.example.com</code>. Note the following:</p> <ul> <li> <p>The * must replace the entire label. For example, you can't specify <code>*prod.example.com</code> or <code>prod*.example.com</code>.</p> </li> <li> <p>The * can't replace any of the middle labels, for example, marketing.*.example.com.</p> </li> <li> <p>If you include * in any position other than the leftmost label in a domain name, DNS treats it as an * character (ASCII 42), not as a wildcard.</p> <important> <p>You can't use the * wildcard for resource records sets that have a type of NS.</p> </important> </li> </ul> <p>You can use the * wildcard as the leftmost label in a domain name, for example, <code>*.example.com</code>. You can't use an * for one of the middle labels, for example, <code>marketing.*.example.com</code>. In addition, the * must replace the entire label; for example, you can't specify <code>prod*.example.com</code>.</p>"];
      type_: RRType.t
        [@ocaml.doc
          "<p>The DNS record type. For information about different record types and how data is encoded for them, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/ResourceRecordTypes.html\">Supported DNS Resource Record Types</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>Valid values for basic resource record sets: <code>A</code> | <code>AAAA</code> | <code>CAA</code> | <code>CNAME</code> | <code>MX</code> | <code>NAPTR</code> | <code>NS</code> | <code>PTR</code> | <code>SOA</code> | <code>SPF</code> | <code>SRV</code> | <code>TXT</code> </p> <p>Values for weighted, latency, geolocation, and failover resource record sets: <code>A</code> | <code>AAAA</code> | <code>CAA</code> | <code>CNAME</code> | <code>MX</code> | <code>NAPTR</code> | <code>PTR</code> | <code>SPF</code> | <code>SRV</code> | <code>TXT</code>. When creating a group of weighted, latency, geolocation, or failover resource record sets, specify the same value for all of the resource record sets in the group.</p> <p>Valid values for multivalue answer resource record sets: <code>A</code> | <code>AAAA</code> | <code>MX</code> | <code>NAPTR</code> | <code>PTR</code> | <code>SPF</code> | <code>SRV</code> | <code>TXT</code> </p> <note> <p>SPF records were formerly used to verify the identity of the sender of email messages. However, we no longer recommend that you create resource record sets for which the value of <code>Type</code> is <code>SPF</code>. RFC 7208, <i>Sender Policy Framework (SPF) for Authorizing Use of Domains in Email, Version 1</i>, has been updated to say, \"...[I]ts existence and mechanism defined in [RFC4408] have led to some interoperability issues. Accordingly, its use is no longer appropriate for SPF version 1; implementations are not to use it.\" In RFC 7208, see section 14.1, <a href=\"http://tools.ietf.org/html/rfc7208#section-14.1\">The SPF DNS Record Type</a>.</p> </note> <p>Values for alias resource record sets:</p> <ul> <li> <p> <b>Amazon API Gateway custom regional APIs and edge-optimized APIs:</b> <code>A</code> </p> </li> <li> <p> <b>CloudFront distributions:</b> <code>A</code> </p> <p>If IPv6 is enabled for the distribution, create two resource record sets to route traffic to your distribution, one with a value of <code>A</code> and one with a value of <code>AAAA</code>. </p> </li> <li> <p> <b>AWS Elastic Beanstalk environment that has a regionalized subdomain</b>: <code>A</code> </p> </li> <li> <p> <b>ELB load balancers:</b> <code>A</code> | <code>AAAA</code> </p> </li> <li> <p> <b>Amazon S3 buckets:</b> <code>A</code> </p> </li> <li> <p> <b>Amazon Virtual Private Cloud interface VPC endpoints</b> <code>A</code> </p> </li> <li> <p> <b>Another resource record set in this hosted zone:</b> Specify the type of the resource record set that you're creating the alias for. All values are supported except <code>NS</code> and <code>SOA</code>.</p> <note> <p>If you're creating an alias record that has the same name as the hosted zone (known as the zone apex), you can't route traffic to a record for which the value of <code>Type</code> is <code>CNAME</code>. This is because the alias record must have the same type as the record you're routing traffic to, and creating a CNAME record for the zone apex isn't supported even for an alias record.</p> </note> </li> </ul>"];
      set_identifier: String.t option
        [@ocaml.doc
          "<p> <i>Resource record sets that have a routing policy other than simple:</i> An identifier that differentiates among multiple resource record sets that have the same combination of name and type, such as multiple weighted resource record sets named acme.example.com that have a type of A. In a group of resource record sets that have the same name and type, the value of <code>SetIdentifier</code> must be unique for each resource record set. </p> <p>For information about routing policies, see <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html\">Choosing a Routing Policy</a> in the <i>Amazon Route 53 Developer Guide</i>.</p>"];
      weight: Long.t option
        [@ocaml.doc
          "<p> <i>Weighted resource record sets only:</i> Among resource record sets that have the same combination of DNS name and type, a value that determines the proportion of DNS queries that Amazon Route 53 responds to using the current resource record set. Route 53 calculates the sum of the weights for the resource record sets that have the same combination of DNS name and type. Route 53 then responds to queries based on the ratio of a resource's weight to the total. Note the following:</p> <ul> <li> <p>You must specify a value for the <code>Weight</code> element for every weighted resource record set.</p> </li> <li> <p>You can only specify one <code>ResourceRecord</code> per weighted resource record set.</p> </li> <li> <p>You can't create latency, failover, or geolocation resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements as weighted resource record sets.</p> </li> <li> <p>You can create a maximum of 100 weighted resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements.</p> </li> <li> <p>For weighted (but not weighted alias) resource record sets, if you set <code>Weight</code> to <code>0</code> for a resource record set, Route 53 never responds to queries with the applicable value for that resource record set. However, if you set <code>Weight</code> to <code>0</code> for all resource record sets that have the same combination of DNS name and type, traffic is routed to all resources with equal probability.</p> <p>The effect of setting <code>Weight</code> to <code>0</code> is different when you associate health checks with weighted resource record sets. For more information, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-configuring-options.html\">Options for Configuring Route 53 Active-Active and Active-Passive Failover</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> </li> </ul>"];
      region: ResourceRecordSetRegion.t option
        [@ocaml.doc
          "<p> <i>Latency-based resource record sets only:</i> The Amazon EC2 Region where you created the resource that this resource record set refers to. The resource typically is an AWS resource, such as an EC2 instance or an ELB load balancer, and is referred to by an IP address or a DNS domain name, depending on the record type.</p> <note> <p>Creating latency and latency alias resource record sets in private hosted zones is not supported.</p> </note> <p>When Amazon Route 53 receives a DNS query for a domain name and type for which you have created latency resource record sets, Route 53 selects the latency resource record set that has the lowest latency between the end user and the associated Amazon EC2 Region. Route 53 then returns the value that is associated with the selected resource record set.</p> <p>Note the following:</p> <ul> <li> <p>You can only specify one <code>ResourceRecord</code> per latency resource record set.</p> </li> <li> <p>You can only create one latency resource record set for each Amazon EC2 Region.</p> </li> <li> <p>You aren't required to create latency resource record sets for all Amazon EC2 Regions. Route 53 will choose the region with the best latency from among the regions that you create latency resource record sets for.</p> </li> <li> <p>You can't create non-latency resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements as latency resource record sets.</p> </li> </ul>"];
      geo_location: GeoLocation.t option
        [@ocaml.doc
          "<p> <i>Geolocation resource record sets only:</i> A complex type that lets you control how Amazon Route 53 responds to DNS queries based on the geographic origin of the query. For example, if you want all queries from Africa to be routed to a web server with an IP address of <code>192.0.2.111</code>, create a resource record set with a <code>Type</code> of <code>A</code> and a <code>ContinentCode</code> of <code>AF</code>.</p> <note> <p>Creating geolocation and geolocation alias resource record sets in private hosted zones is not supported.</p> </note> <p>If you create separate resource record sets for overlapping geographic regions (for example, one resource record set for a continent and one for a country on the same continent), priority goes to the smallest geographic region. This allows you to route most queries for a continent to one resource and to route queries for a country on that continent to a different resource.</p> <p>You can't create two geolocation resource record sets that specify the same geographic location.</p> <p>The value <code>*</code> in the <code>CountryCode</code> element matches all geographic locations that aren't specified in other geolocation resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements.</p> <important> <p>Geolocation works by mapping IP addresses to locations. However, some IP addresses aren't mapped to geographic locations, so even if you create geolocation resource record sets that cover all seven continents, Route 53 will receive some DNS queries from locations that it can't identify. We recommend that you create a resource record set for which the value of <code>CountryCode</code> is <code>*</code>, which handles both queries that come from locations for which you haven't created geolocation resource record sets and queries from IP addresses that aren't mapped to a location. If you don't create a <code>*</code> resource record set, Route 53 returns a \"no answer\" response for queries from those locations.</p> </important> <p>You can't create non-geolocation resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements as geolocation resource record sets.</p>"];
      failover: ResourceRecordSetFailover.t option
        [@ocaml.doc
          "<p> <i>Failover resource record sets only:</i> To configure failover, you add the <code>Failover</code> element to two resource record sets. For one resource record set, you specify <code>PRIMARY</code> as the value for <code>Failover</code>; for the other resource record set, you specify <code>SECONDARY</code>. In addition, you include the <code>HealthCheckId</code> element and specify the health check that you want Amazon Route 53 to perform for each resource record set.</p> <p>Except where noted, the following failover behaviors assume that you have included the <code>HealthCheckId</code> element in both resource record sets:</p> <ul> <li> <p>When the primary resource record set is healthy, Route 53 responds to DNS queries with the applicable value from the primary resource record set regardless of the health of the secondary resource record set.</p> </li> <li> <p>When the primary resource record set is unhealthy and the secondary resource record set is healthy, Route 53 responds to DNS queries with the applicable value from the secondary resource record set.</p> </li> <li> <p>When the secondary resource record set is unhealthy, Route 53 responds to DNS queries with the applicable value from the primary resource record set regardless of the health of the primary resource record set.</p> </li> <li> <p>If you omit the <code>HealthCheckId</code> element for the secondary resource record set, and if the primary resource record set is unhealthy, Route 53 always responds to DNS queries with the applicable value from the secondary resource record set. This is true regardless of the health of the associated endpoint.</p> </li> </ul> <p>You can't create non-failover resource record sets that have the same values for the <code>Name</code> and <code>Type</code> elements as failover resource record sets.</p> <p>For failover alias resource record sets, you must also include the <code>EvaluateTargetHealth</code> element and set the value to true.</p> <p>For more information about configuring failover for Route 53, see the following topics in the <i>Amazon Route 53 Developer Guide</i>: </p> <ul> <li> <p> <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover.html\">Route 53 Health Checks and DNS Failover</a> </p> </li> <li> <p> <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-private-hosted-zones.html\">Configuring Failover in a Private Hosted Zone</a> </p> </li> </ul>"];
      multi_value_answer: Boolean.t option
        [@ocaml.doc
          "<p> <i>Multivalue answer resource record sets only</i>: To route traffic approximately randomly to multiple resources, such as web servers, create one multivalue answer record for each resource and specify <code>true</code> for <code>MultiValueAnswer</code>. Note the following:</p> <ul> <li> <p>If you associate a health check with a multivalue answer resource record set, Amazon Route 53 responds to DNS queries with the corresponding IP address only when the health check is healthy.</p> </li> <li> <p>If you don't associate a health check with a multivalue answer record, Route 53 always considers the record to be healthy.</p> </li> <li> <p>Route 53 responds to DNS queries with up to eight healthy records; if you have eight or fewer healthy records, Route 53 responds to all DNS queries with all the healthy records.</p> </li> <li> <p>If you have more than eight healthy records, Route 53 responds to different DNS resolvers with different combinations of healthy records.</p> </li> <li> <p>When all records are unhealthy, Route 53 responds to DNS queries with up to eight unhealthy records.</p> </li> <li> <p>If a resource becomes unavailable after a resolver caches a response, client software typically tries another of the IP addresses in the response.</p> </li> </ul> <p>You can't create multivalue answer alias records.</p>"];
      t_t_l: Long.t option
        [@ocaml.doc
          "<p>The resource record cache time to live (TTL), in seconds. Note the following:</p> <ul> <li> <p>If you're creating or updating an alias resource record set, omit <code>TTL</code>. Amazon Route 53 uses the value of <code>TTL</code> for the alias target. </p> </li> <li> <p>If you're associating this resource record set with a health check (if you're adding a <code>HealthCheckId</code> element), we recommend that you specify a <code>TTL</code> of 60 seconds or less so clients respond quickly to changes in health status.</p> </li> <li> <p>All of the resource record sets in a group of weighted resource record sets must have the same value for <code>TTL</code>.</p> </li> <li> <p>If a group of weighted resource record sets includes one or more weighted alias resource record sets for which the alias target is an ELB load balancer, we recommend that you specify a <code>TTL</code> of 60 seconds for all of the non-alias weighted resource record sets that have the same name and type. Values other than 60 seconds (the TTL for load balancers) will change the effect of the values that you specify for <code>Weight</code>.</p> </li> </ul>"];
      resource_records: ResourceRecords.t
        [@ocaml.doc
          "<p>Information about the resource records to act upon.</p> <note> <p>If you're creating an alias resource record set, omit <code>ResourceRecords</code>.</p> </note>"];
      alias_target: AliasTarget.t option
        [@ocaml.doc
          "<p> <i>Alias resource record sets only:</i> Information about the AWS resource, such as a CloudFront distribution or an Amazon S3 bucket, that you want to route traffic to. </p> <p>If you're creating resource records sets for a private hosted zone, note the following:</p> <ul> <li> <p>You can't create an alias resource record set in a private hosted zone to route traffic to a CloudFront distribution.</p> </li> <li> <p>Creating geolocation alias resource record sets or latency alias resource record sets in a private hosted zone is unsupported.</p> </li> <li> <p>For information about creating failover resource record sets in a private hosted zone, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-private-hosted-zones.html\">Configuring Failover in a Private Hosted Zone</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> </li> </ul>"];
      health_check_id: String.t option
        [@ocaml.doc
          "<p>If you want Amazon Route 53 to return this resource record set in response to a DNS query only when the status of a health check is healthy, include the <code>HealthCheckId</code> element and specify the ID of the applicable health check.</p> <p>Route 53 determines whether a resource record set is healthy based on one of the following:</p> <ul> <li> <p>By periodically sending a request to the endpoint that is specified in the health check</p> </li> <li> <p>By aggregating the status of a specified group of health checks (calculated health checks)</p> </li> <li> <p>By determining the current state of a CloudWatch alarm (CloudWatch metric health checks)</p> </li> </ul> <important> <p>Route 53 doesn't check the health of the endpoint that is specified in the resource record set, for example, the endpoint specified by the IP address in the <code>Value</code> element. When you add a <code>HealthCheckId</code> element to a resource record set, Route 53 checks the health of the endpoint that you specified in the health check. </p> </important> <p>For more information, see the following topics in the <i>Amazon Route 53 Developer Guide</i>:</p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-determining-health-of-endpoints.html\">How Amazon Route 53 Determines Whether an Endpoint Is Healthy</a> </p> </li> <li> <p> <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover.html\">Route 53 Health Checks and DNS Failover</a> </p> </li> <li> <p> <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-private-hosted-zones.html\">Configuring Failover in a Private Hosted Zone</a> </p> </li> </ul> <p> <b>When to Specify HealthCheckId</b> </p> <p>Specifying a value for <code>HealthCheckId</code> is useful only when Route 53 is choosing between two or more resource record sets to respond to a DNS query, and you want Route 53 to base the choice in part on the status of a health check. Configuring health checks makes sense only in the following configurations:</p> <ul> <li> <p> <b>Non-alias resource record sets</b>: You're checking the health of a group of non-alias resource record sets that have the same routing policy, name, and type (such as multiple weighted records named www.example.com with a type of A) and you specify health check IDs for all the resource record sets. </p> <p>If the health check status for a resource record set is healthy, Route 53 includes the record among the records that it responds to DNS queries with.</p> <p>If the health check status for a resource record set is unhealthy, Route 53 stops responding to DNS queries using the value for that resource record set.</p> <p>If the health check status for all resource record sets in the group is unhealthy, Route 53 considers all resource record sets in the group healthy and responds to DNS queries accordingly. </p> </li> <li> <p> <b>Alias resource record sets</b>: You specify the following settings:</p> <ul> <li> <p>You set <code>EvaluateTargetHealth</code> to true for an alias resource record set in a group of resource record sets that have the same routing policy, name, and type (such as multiple weighted records named www.example.com with a type of A). </p> </li> <li> <p>You configure the alias resource record set to route traffic to a non-alias resource record set in the same hosted zone.</p> </li> <li> <p>You specify a health check ID for the non-alias resource record set. </p> </li> </ul> <p>If the health check status is healthy, Route 53 considers the alias resource record set to be healthy and includes the alias record among the records that it responds to DNS queries with.</p> <p>If the health check status is unhealthy, Route 53 stops responding to DNS queries using the alias resource record set.</p> <note> <p>The alias resource record set can also route traffic to a <i>group</i> of non-alias resource record sets that have the same routing policy, name, and type. In that configuration, associate health checks with all of the resource record sets in the group of non-alias resource record sets.</p> </note> </li> </ul> <p> <b>Geolocation Routing</b> </p> <p>For geolocation resource record sets, if an endpoint is unhealthy, Route 53 looks for a resource record set for the larger, associated geographic region. For example, suppose you have resource record sets for a state in the United States, for the entire United States, for North America, and a resource record set that has <code>*</code> for <code>CountryCode</code> is <code>*</code>, which applies to all locations. If the endpoint for the state resource record set is unhealthy, Route 53 checks for healthy resource record sets in the following order until it finds a resource record set for which the endpoint is healthy:</p> <ul> <li> <p>The United States</p> </li> <li> <p>North America</p> </li> <li> <p>The default resource record set</p> </li> </ul> <p> <b>Specifying the Health Check Endpoint by Domain Name</b> </p> <p>If your health checks specify the endpoint only by domain name, we recommend that you create a separate health check for each endpoint. For example, create a health check for each <code>HTTP</code> server that is serving content for <code>www.example.com</code>. For the value of <code>FullyQualifiedDomainName</code>, specify the domain name of the server (such as <code>us-east-2-www.example.com</code>), not the name of the resource record sets (<code>www.example.com</code>).</p> <important> <p>Health check results will be unpredictable if you do the following:</p> <ul> <li> <p>Create a health check that has the same value for <code>FullyQualifiedDomainName</code> as the name of a resource record set.</p> </li> <li> <p>Associate that health check with the resource record set.</p> </li> </ul> </important>"];
      traffic_policy_instance_id: String.t option
        [@ocaml.doc
          "<p>When you create a traffic policy instance, Amazon Route 53 automatically creates a resource record set. <code>TrafficPolicyInstanceId</code> is the ID of the traffic policy instance that Route 53 created this resource record set for.</p> <important> <p>To delete the resource record set that is associated with a traffic policy instance, use <code>DeleteTrafficPolicyInstance</code>. Route 53 will delete the resource record set automatically. If you delete the resource record set by using <code>ChangeResourceRecordSets</code>, Route 53 doesn't automatically delete the traffic policy instance, and you'll continue to be charged for it even though it's no longer in use. </p> </important>"]}
    [@@ocaml.doc
      "<p>Information about the resource record set to create or delete.</p>"]
    let make ~name  ~type_  ?set_identifier  ?weight  ?region  ?geo_location 
      ?failover  ?multi_value_answer  ?t_t_l  ?(resource_records= []) 
      ?alias_target  ?health_check_id  ?traffic_policy_instance_id  () =
      {
        name;
        type_;
        set_identifier;
        weight;
        region;
        geo_location;
        failover;
        multi_value_answer;
        t_t_l;
        resource_records;
        alias_target;
        health_check_id;
        traffic_policy_instance_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.traffic_policy_instance_id
              (fun f -> ("traffic_policy_instance_id", (String.to_json f)));
           Util.option_map v.health_check_id
             (fun f -> ("health_check_id", (String.to_json f)));
           Util.option_map v.alias_target
             (fun f -> ("alias_target", (AliasTarget.to_json f)));
           Some
             ("resource_records",
               (ResourceRecords.to_json v.resource_records));
           Util.option_map v.t_t_l (fun f -> ("t_t_l", (Long.to_json f)));
           Util.option_map v.multi_value_answer
             (fun f -> ("multi_value_answer", (Boolean.to_json f)));
           Util.option_map v.failover
             (fun f -> ("failover", (ResourceRecordSetFailover.to_json f)));
           Util.option_map v.geo_location
             (fun f -> ("geo_location", (GeoLocation.to_json f)));
           Util.option_map v.region
             (fun f -> ("region", (ResourceRecordSetRegion.to_json f)));
           Util.option_map v.weight (fun f -> ("weight", (Long.to_json f)));
           Util.option_map v.set_identifier
             (fun f -> ("set_identifier", (String.to_json f)));
           Some ("type_", (RRType.to_json v.type_));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml) RRType.parse));
          set_identifier =
            (Util.option_bind (Xml.member "SetIdentifier" xml) String.parse);
          weight = (Util.option_bind (Xml.member "Weight" xml) Long.parse);
          region =
            (Util.option_bind (Xml.member "Region" xml)
               ResourceRecordSetRegion.parse);
          geo_location =
            (Util.option_bind (Xml.member "GeoLocation" xml)
               GeoLocation.parse);
          failover =
            (Util.option_bind (Xml.member "Failover" xml)
               ResourceRecordSetFailover.parse);
          multi_value_answer =
            (Util.option_bind (Xml.member "MultiValueAnswer" xml)
               Boolean.parse);
          t_t_l = (Util.option_bind (Xml.member "TTL" xml) Long.parse);
          resource_records =
            (Util.of_option []
               (Util.option_bind (Xml.member "ResourceRecords" xml)
                  ResourceRecords.parse));
          alias_target =
            (Util.option_bind (Xml.member "AliasTarget" xml)
               AliasTarget.parse);
          health_check_id =
            (Util.option_bind (Xml.member "HealthCheckId" xml) String.parse);
          traffic_policy_instance_id =
            (Util.option_bind (Xml.member "TrafficPolicyInstanceId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((([] @
                       [Some
                          (Ezxmlm.make_tag "Name"
                             ([], (String.to_xml v.name)))])
                      @
                      [Some
                         (Ezxmlm.make_tag "Type"
                            ([], (RRType.to_xml v.type_)))])
                     @
                     [Util.option_map v.set_identifier
                        (fun f ->
                           Ezxmlm.make_tag "SetIdentifier"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.weight
                       (fun f ->
                          Ezxmlm.make_tag "Weight" ([], (Long.to_xml f)))])
                   @
                   [Util.option_map v.region
                      (fun f ->
                         Ezxmlm.make_tag "Region"
                           ([], (ResourceRecordSetRegion.to_xml f)))])
                  @
                  [Util.option_map v.geo_location
                     (fun f ->
                        Ezxmlm.make_tag "GeoLocation"
                          ([], (GeoLocation.to_xml f)))])
                 @
                 [Util.option_map v.failover
                    (fun f ->
                       Ezxmlm.make_tag "Failover"
                         ([], (ResourceRecordSetFailover.to_xml f)))])
                @
                [Util.option_map v.multi_value_answer
                   (fun f ->
                      Ezxmlm.make_tag "MultiValueAnswer"
                        ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.t_t_l
                  (fun f -> Ezxmlm.make_tag "TTL" ([], (Long.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "ResourceRecords"
                         ([], (ResourceRecords.to_xml [x]))))
                 v.resource_records))
             @
             [Util.option_map v.alias_target
                (fun f ->
                   Ezxmlm.make_tag "AliasTarget" ([], (AliasTarget.to_xml f)))])
            @
            [Util.option_map v.health_check_id
               (fun f ->
                  Ezxmlm.make_tag "HealthCheckId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.traffic_policy_instance_id
              (fun f ->
                 Ezxmlm.make_tag "TrafficPolicyInstanceId"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Information about the resource record set to create or delete.</p>"]
module HostedZoneConfig =
  struct
    type t =
      {
      comment: String.t option
        [@ocaml.doc
          "<p>Any comments that you want to include about the hosted zone.</p>"];
      private_zone: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether this is a private hosted zone.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains an optional comment about your hosted zone. If you don't want to specify a comment, omit both the <code>HostedZoneConfig</code> and <code>Comment</code> elements.</p>"]
    let make ?comment  ?private_zone  () = { comment; private_zone }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.private_zone
              (fun f -> ("private_zone", (Boolean.to_json f)));
           Util.option_map v.comment
             (fun f -> ("comment", (String.to_json f)))])
    let parse xml =
      Some
        {
          comment =
            (Util.option_bind (Xml.member "Comment" xml) String.parse);
          private_zone =
            (Util.option_bind (Xml.member "PrivateZone" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.comment
               (fun f -> Ezxmlm.make_tag "Comment" ([], (String.to_xml f)))])
           @
           [Util.option_map v.private_zone
              (fun f ->
                 Ezxmlm.make_tag "PrivateZone" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains an optional comment about your hosted zone. If you don't want to specify a comment, omit both the <code>HostedZoneConfig</code> and <code>Comment</code> elements.</p>"]
module LinkedService =
  struct
    type t =
      {
      service_principal: String.t option
        [@ocaml.doc
          "<p>If the health check or hosted zone was created by another service, the service that created the resource. When a resource is created by another service, you can't edit or delete it using Amazon Route 53. </p>"];
      description: String.t option
        [@ocaml.doc
          "<p>If the health check or hosted zone was created by another service, an optional description that can be provided by the other service. When a resource is created by another service, you can't edit or delete it using Amazon Route 53. </p>"]}
    [@@ocaml.doc
      "<p>If a health check or hosted zone was created by another service, <code>LinkedService</code> is a complex type that describes the service that created the resource. When a resource is created by another service, you can't edit or delete it using Amazon Route 53. </p>"]
    let make ?service_principal  ?description  () =
      { service_principal; description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.service_principal
             (fun f -> ("service_principal", (String.to_json f)))])
    let parse xml =
      Some
        {
          service_principal =
            (Util.option_bind (Xml.member "ServicePrincipal" xml)
               String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.service_principal
               (fun f ->
                  Ezxmlm.make_tag "ServicePrincipal" ([], (String.to_xml f)))])
           @
           [Util.option_map v.description
              (fun f -> Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>If a health check or hosted zone was created by another service, <code>LinkedService</code> is a complex type that describes the service that created the resource. When a resource is created by another service, you can't edit or delete it using Amazon Route 53. </p>"]
module StatusReport =
  struct
    type t =
      {
      status: String.t option
        [@ocaml.doc
          "<p>A description of the status of the health check endpoint as reported by one of the Amazon Route 53 health checkers.</p>"];
      checked_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time that the health checker performed the health check in <a href=\"https://en.wikipedia.org/wiki/ISO_8601\">ISO 8601 format</a> and Coordinated Universal Time (UTC). For example, the value <code>2017-03-27T17:48:16.751Z</code> represents March 27, 2017 at 17:48:16.751 UTC.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the status that one Amazon Route 53 health checker reports and the time of the health check.</p>"]
    let make ?status  ?checked_time  () = { status; checked_time }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.checked_time
              (fun f -> ("checked_time", (DateTime.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)))])
    let parse xml =
      Some
        {
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          checked_time =
            (Util.option_bind (Xml.member "CheckedTime" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.status
               (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
           @
           [Util.option_map v.checked_time
              (fun f ->
                 Ezxmlm.make_tag "CheckedTime" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the status that one Amazon Route 53 health checker reports and the time of the health check.</p>"]
module VPCRegion =
  struct
    type t =
      | Us_east_1 
      | Us_east_2 
      | Us_west_1 
      | Us_west_2 
      | Eu_west_1 
      | Eu_west_2 
      | Eu_west_3 
      | Eu_central_1 
      | Ap_east_1 
      | Me_south_1 
      | Ap_southeast_1 
      | Ap_southeast_2 
      | Ap_south_1 
      | Ap_northeast_1 
      | Ap_northeast_2 
      | Ap_northeast_3 
      | Eu_north_1 
      | Sa_east_1 
      | Ca_central_1 
      | Cn_north_1 
    let str_to_t =
      [("cn-north-1", Cn_north_1);
      ("ca-central-1", Ca_central_1);
      ("sa-east-1", Sa_east_1);
      ("eu-north-1", Eu_north_1);
      ("ap-northeast-3", Ap_northeast_3);
      ("ap-northeast-2", Ap_northeast_2);
      ("ap-northeast-1", Ap_northeast_1);
      ("ap-south-1", Ap_south_1);
      ("ap-southeast-2", Ap_southeast_2);
      ("ap-southeast-1", Ap_southeast_1);
      ("me-south-1", Me_south_1);
      ("ap-east-1", Ap_east_1);
      ("eu-central-1", Eu_central_1);
      ("eu-west-3", Eu_west_3);
      ("eu-west-2", Eu_west_2);
      ("eu-west-1", Eu_west_1);
      ("us-west-2", Us_west_2);
      ("us-west-1", Us_west_1);
      ("us-east-2", Us_east_2);
      ("us-east-1", Us_east_1)]
    let t_to_str =
      [(Cn_north_1, "cn-north-1");
      (Ca_central_1, "ca-central-1");
      (Sa_east_1, "sa-east-1");
      (Eu_north_1, "eu-north-1");
      (Ap_northeast_3, "ap-northeast-3");
      (Ap_northeast_2, "ap-northeast-2");
      (Ap_northeast_1, "ap-northeast-1");
      (Ap_south_1, "ap-south-1");
      (Ap_southeast_2, "ap-southeast-2");
      (Ap_southeast_1, "ap-southeast-1");
      (Me_south_1, "me-south-1");
      (Ap_east_1, "ap-east-1");
      (Eu_central_1, "eu-central-1");
      (Eu_west_3, "eu-west-3");
      (Eu_west_2, "eu-west-2");
      (Eu_west_1, "eu-west-1");
      (Us_west_2, "us-west-2");
      (Us_west_1, "us-west-1");
      (Us_east_2, "us-east-2");
      (Us_east_1, "us-east-1")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module CloudWatchAlarmConfiguration =
  struct
    type t =
      {
      evaluation_periods: Integer.t
        [@ocaml.doc
          "<p>For the metric that the CloudWatch alarm is associated with, the number of periods that the metric is compared to the threshold.</p>"];
      threshold: Double.t
        [@ocaml.doc
          "<p>For the metric that the CloudWatch alarm is associated with, the value the metric is compared with.</p>"];
      comparison_operator: ComparisonOperator.t
        [@ocaml.doc
          "<p>For the metric that the CloudWatch alarm is associated with, the arithmetic operation that is used for the comparison.</p>"];
      period: Integer.t
        [@ocaml.doc
          "<p>For the metric that the CloudWatch alarm is associated with, the duration of one evaluation period in seconds.</p>"];
      metric_name: String.t
        [@ocaml.doc
          "<p>The name of the CloudWatch metric that the alarm is associated with.</p>"];
      namespace: String.t
        [@ocaml.doc
          "<p>The namespace of the metric that the alarm is associated with. For more information, see <a href=\"http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html\">Amazon CloudWatch Namespaces, Dimensions, and Metrics Reference</a> in the <i>Amazon CloudWatch User Guide</i>.</p>"];
      statistic: Statistic.t
        [@ocaml.doc
          "<p>For the metric that the CloudWatch alarm is associated with, the statistic that is applied to the metric.</p>"];
      dimensions: DimensionList.t
        [@ocaml.doc
          "<p>For the metric that the CloudWatch alarm is associated with, a complex type that contains information about the dimensions for the metric. For information, see <a href=\"http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html\">Amazon CloudWatch Namespaces, Dimensions, and Metrics Reference</a> in the <i>Amazon CloudWatch User Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the CloudWatch alarm that Amazon Route 53 is monitoring for this health check.</p>"]
    let make ~evaluation_periods  ~threshold  ~comparison_operator  ~period 
      ~metric_name  ~namespace  ~statistic  ?(dimensions= [])  () =
      {
        evaluation_periods;
        threshold;
        comparison_operator;
        period;
        metric_name;
        namespace;
        statistic;
        dimensions
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("dimensions", (DimensionList.to_json v.dimensions));
           Some ("statistic", (Statistic.to_json v.statistic));
           Some ("namespace", (String.to_json v.namespace));
           Some ("metric_name", (String.to_json v.metric_name));
           Some ("period", (Integer.to_json v.period));
           Some
             ("comparison_operator",
               (ComparisonOperator.to_json v.comparison_operator));
           Some ("threshold", (Double.to_json v.threshold));
           Some
             ("evaluation_periods", (Integer.to_json v.evaluation_periods))])
    let parse xml =
      Some
        {
          evaluation_periods =
            (Xml.required "EvaluationPeriods"
               (Util.option_bind (Xml.member "EvaluationPeriods" xml)
                  Integer.parse));
          threshold =
            (Xml.required "Threshold"
               (Util.option_bind (Xml.member "Threshold" xml) Double.parse));
          comparison_operator =
            (Xml.required "ComparisonOperator"
               (Util.option_bind (Xml.member "ComparisonOperator" xml)
                  ComparisonOperator.parse));
          period =
            (Xml.required "Period"
               (Util.option_bind (Xml.member "Period" xml) Integer.parse));
          metric_name =
            (Xml.required "MetricName"
               (Util.option_bind (Xml.member "MetricName" xml) String.parse));
          namespace =
            (Xml.required "Namespace"
               (Util.option_bind (Xml.member "Namespace" xml) String.parse));
          statistic =
            (Xml.required "Statistic"
               (Util.option_bind (Xml.member "Statistic" xml) Statistic.parse));
          dimensions =
            (Util.of_option []
               (Util.option_bind (Xml.member "Dimensions" xml)
                  DimensionList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Some
                     (Ezxmlm.make_tag "EvaluationPeriods"
                        ([], (Integer.to_xml v.evaluation_periods)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "Threshold"
                       ([], (Double.to_xml v.threshold)))])
                @
                [Some
                   (Ezxmlm.make_tag "ComparisonOperator"
                      ([], (ComparisonOperator.to_xml v.comparison_operator)))])
               @
               [Some
                  (Ezxmlm.make_tag "Period" ([], (Integer.to_xml v.period)))])
              @
              [Some
                 (Ezxmlm.make_tag "MetricName"
                    ([], (String.to_xml v.metric_name)))])
             @
             [Some
                (Ezxmlm.make_tag "Namespace"
                   ([], (String.to_xml v.namespace)))])
            @
            [Some
               (Ezxmlm.make_tag "Statistic"
                  ([], (Statistic.to_xml v.statistic)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Dimensions"
                      ([], (DimensionList.to_xml [x])))) v.dimensions))
  end[@@ocaml.doc
       "<p>A complex type that contains information about the CloudWatch alarm that Amazon Route 53 is monitoring for this health check.</p>"]
module HealthCheckConfig =
  struct
    type t =
      {
      i_p_address: String.t option
        [@ocaml.doc
          "<p>The IPv4 or IPv6 IP address of the endpoint that you want Amazon Route 53 to perform health checks on. If you don't specify a value for <code>IPAddress</code>, Route 53 sends a DNS request to resolve the domain name that you specify in <code>FullyQualifiedDomainName</code> at the interval that you specify in <code>RequestInterval</code>. Using an IP address returned by DNS, Route 53 then checks the health of the endpoint.</p> <p>Use one of the following formats for the value of <code>IPAddress</code>: </p> <ul> <li> <p> <b>IPv4 address</b>: four values between 0 and 255, separated by periods (.), for example, <code>192.0.2.44</code>.</p> </li> <li> <p> <b>IPv6 address</b>: eight groups of four hexadecimal values, separated by colons (:), for example, <code>2001:0db8:85a3:0000:0000:abcd:0001:2345</code>. You can also shorten IPv6 addresses as described in RFC 5952, for example, <code>2001:db8:85a3::abcd:1:2345</code>.</p> </li> </ul> <p>If the endpoint is an EC2 instance, we recommend that you create an Elastic IP address, associate it with your EC2 instance, and specify the Elastic IP address for <code>IPAddress</code>. This ensures that the IP address of your instance will never change.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_UpdateHealthCheck.html#Route53-UpdateHealthCheck-request-FullyQualifiedDomainName\">FullyQualifiedDomainName</a>. </p> <p>Constraints: Route 53 can't check the health of endpoints for which the IP address is in local, private, non-routable, or multicast ranges. For more information about IP addresses for which you can't create health checks, see the following documents:</p> <ul> <li> <p> <a href=\"https://tools.ietf.org/html/rfc5735\">RFC 5735, Special Use IPv4 Addresses</a> </p> </li> <li> <p> <a href=\"https://tools.ietf.org/html/rfc6598\">RFC 6598, IANA-Reserved IPv4 Prefix for Shared Address Space</a> </p> </li> <li> <p> <a href=\"https://tools.ietf.org/html/rfc5156\">RFC 5156, Special-Use IPv6 Addresses</a> </p> </li> </ul> <p>When the value of <code>Type</code> is <code>CALCULATED</code> or <code>CLOUDWATCH_METRIC</code>, omit <code>IPAddress</code>.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port on the endpoint on which you want Amazon Route 53 to perform health checks. Specify a value for <code>Port</code> only when you specify a value for <code>IPAddress</code>.</p>"];
      type_: HealthCheckType.t
        [@ocaml.doc
          "<p>The type of health check that you want to create, which indicates how Amazon Route 53 determines whether an endpoint is healthy.</p> <important> <p>You can't change the value of <code>Type</code> after you create a health check.</p> </important> <p>You can create the following types of health checks:</p> <ul> <li> <p> <b>HTTP</b>: Route 53 tries to establish a TCP connection. If successful, Route 53 submits an HTTP request and waits for an HTTP status code of 200 or greater and less than 400.</p> </li> <li> <p> <b>HTTPS</b>: Route 53 tries to establish a TCP connection. If successful, Route 53 submits an HTTPS request and waits for an HTTP status code of 200 or greater and less than 400.</p> <important> <p>If you specify <code>HTTPS</code> for the value of <code>Type</code>, the endpoint must support TLS v1.0 or later.</p> </important> </li> <li> <p> <b>HTTP_STR_MATCH</b>: Route 53 tries to establish a TCP connection. If successful, Route 53 submits an HTTP request and searches the first 5,120 bytes of the response body for the string that you specify in <code>SearchString</code>.</p> </li> <li> <p> <b>HTTPS_STR_MATCH</b>: Route 53 tries to establish a TCP connection. If successful, Route 53 submits an <code>HTTPS</code> request and searches the first 5,120 bytes of the response body for the string that you specify in <code>SearchString</code>.</p> </li> <li> <p> <b>TCP</b>: Route 53 tries to establish a TCP connection.</p> </li> <li> <p> <b>CLOUDWATCH_METRIC</b>: The health check is associated with a CloudWatch alarm. If the state of the alarm is <code>OK</code>, the health check is considered healthy. If the state is <code>ALARM</code>, the health check is considered unhealthy. If CloudWatch doesn't have sufficient data to determine whether the state is <code>OK</code> or <code>ALARM</code>, the health check status depends on the setting for <code>InsufficientDataHealthStatus</code>: <code>Healthy</code>, <code>Unhealthy</code>, or <code>LastKnownStatus</code>. </p> </li> <li> <p> <b>CALCULATED</b>: For health checks that monitor the status of other health checks, Route 53 adds up the number of health checks that Route 53 health checkers consider to be healthy and compares that number with the value of <code>HealthThreshold</code>. </p> </li> </ul> <p>For more information, see <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-determining-health-of-endpoints.html\">How Route 53 Determines Whether an Endpoint Is Healthy</a> in the <i>Amazon Route 53 Developer Guide</i>.</p>"];
      resource_path: String.t option
        [@ocaml.doc
          "<p>The path, if any, that you want Amazon Route 53 to request when performing health checks. The path can be any value for which your endpoint will return an HTTP status code of 2xx or 3xx when the endpoint is healthy, for example, the file /docs/route53-health-check.html. You can also include query string parameters, for example, <code>/welcome.html?language=jp&amp;login=y</code>. </p>"];
      fully_qualified_domain_name: String.t option
        [@ocaml.doc
          "<p>Amazon Route 53 behavior depends on whether you specify a value for <code>IPAddress</code>.</p> <p> <b>If you specify a value for</b> <code>IPAddress</code>:</p> <p>Amazon Route 53 sends health check requests to the specified IPv4 or IPv6 address and passes the value of <code>FullyQualifiedDomainName</code> in the <code>Host</code> header for all health checks except TCP health checks. This is typically the fully qualified DNS name of the endpoint on which you want Route 53 to perform health checks.</p> <p>When Route 53 checks the health of an endpoint, here is how it constructs the <code>Host</code> header:</p> <ul> <li> <p>If you specify a value of <code>80</code> for <code>Port</code> and <code>HTTP</code> or <code>HTTP_STR_MATCH</code> for <code>Type</code>, Route 53 passes the value of <code>FullyQualifiedDomainName</code> to the endpoint in the Host header. </p> </li> <li> <p>If you specify a value of <code>443</code> for <code>Port</code> and <code>HTTPS</code> or <code>HTTPS_STR_MATCH</code> for <code>Type</code>, Route 53 passes the value of <code>FullyQualifiedDomainName</code> to the endpoint in the <code>Host</code> header.</p> </li> <li> <p>If you specify another value for <code>Port</code> and any value except <code>TCP</code> for <code>Type</code>, Route 53 passes <code>FullyQualifiedDomainName:Port</code> to the endpoint in the <code>Host</code> header.</p> </li> </ul> <p>If you don't specify a value for <code>FullyQualifiedDomainName</code>, Route 53 substitutes the value of <code>IPAddress</code> in the <code>Host</code> header in each of the preceding cases.</p> <p> <b>If you don't specify a value for <code>IPAddress</code> </b>:</p> <p>Route 53 sends a DNS request to the domain that you specify for <code>FullyQualifiedDomainName</code> at the interval that you specify for <code>RequestInterval</code>. Using an IPv4 address that DNS returns, Route 53 then checks the health of the endpoint.</p> <note> <p>If you don't specify a value for <code>IPAddress</code>, Route 53 uses only IPv4 to send health checks to the endpoint. If there's no resource record set with a type of A for the name that you specify for <code>FullyQualifiedDomainName</code>, the health check fails with a \"DNS resolution failed\" error.</p> </note> <p>If you want to check the health of weighted, latency, or failover resource record sets and you choose to specify the endpoint only by <code>FullyQualifiedDomainName</code>, we recommend that you create a separate health check for each endpoint. For example, create a health check for each HTTP server that is serving content for www.example.com. For the value of <code>FullyQualifiedDomainName</code>, specify the domain name of the server (such as us-east-2-www.example.com), not the name of the resource record sets (www.example.com).</p> <important> <p>In this configuration, if you create a health check for which the value of <code>FullyQualifiedDomainName</code> matches the name of the resource record sets and you then associate the health check with those resource record sets, health check results will be unpredictable.</p> </important> <p>In addition, if the value that you specify for <code>Type</code> is <code>HTTP</code>, <code>HTTPS</code>, <code>HTTP_STR_MATCH</code>, or <code>HTTPS_STR_MATCH</code>, Route 53 passes the value of <code>FullyQualifiedDomainName</code> in the <code>Host</code> header, as it does when you specify a value for <code>IPAddress</code>. If the value of <code>Type</code> is <code>TCP</code>, Route 53 doesn't pass a <code>Host</code> header.</p>"];
      search_string: String.t option
        [@ocaml.doc
          "<p>If the value of Type is <code>HTTP_STR_MATCH</code> or <code>HTTP_STR_MATCH</code>, the string that you want Amazon Route 53 to search for in the response body from the specified resource. If the string appears in the response body, Route 53 considers the resource healthy.</p> <p>Route 53 considers case when searching for <code>SearchString</code> in the response body. </p>"];
      request_interval: Integer.t option
        [@ocaml.doc
          "<p>The number of seconds between the time that Amazon Route 53 gets a response from your endpoint and the time that it sends the next health check request. Each Route 53 health checker makes requests at this interval.</p> <important> <p>You can't change the value of <code>RequestInterval</code> after you create a health check.</p> </important> <p>If you don't specify a value for <code>RequestInterval</code>, the default value is <code>30</code> seconds.</p>"];
      failure_threshold: Integer.t option
        [@ocaml.doc
          "<p>The number of consecutive health checks that an endpoint must pass or fail for Amazon Route 53 to change the current status of the endpoint from unhealthy to healthy or vice versa. For more information, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-determining-health-of-endpoints.html\">How Amazon Route 53 Determines Whether an Endpoint Is Healthy</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>If you don't specify a value for <code>FailureThreshold</code>, the default value is three health checks.</p>"];
      measure_latency: Boolean.t option
        [@ocaml.doc
          "<p>Specify whether you want Amazon Route 53 to measure the latency between health checkers in multiple AWS regions and your endpoint, and to display CloudWatch latency graphs on the <b>Health Checks</b> page in the Route 53 console.</p> <important> <p>You can't change the value of <code>MeasureLatency</code> after you create a health check.</p> </important>"];
      inverted: Boolean.t option
        [@ocaml.doc
          "<p>Specify whether you want Amazon Route 53 to invert the status of a health check, for example, to consider a health check unhealthy when it otherwise would be considered healthy.</p>"];
      disabled: Boolean.t option
        [@ocaml.doc
          "<p>Stops Route 53 from performing health checks. When you disable a health check, here's what happens:</p> <ul> <li> <p> <b>Health checks that check the health of endpoints:</b> Route 53 stops submitting requests to your application, server, or other resource.</p> </li> <li> <p> <b>Calculated health checks:</b> Route 53 stops aggregating the status of the referenced health checks.</p> </li> <li> <p> <b>Health checks that monitor CloudWatch alarms:</b> Route 53 stops monitoring the corresponding CloudWatch metrics.</p> </li> </ul> <p>After you disable a health check, Route 53 considers the status of the health check to always be healthy. If you configured DNS failover, Route 53 continues to route traffic to the corresponding resources. If you want to stop routing traffic to a resource, change the value of <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_UpdateHealthCheck.html#Route53-UpdateHealthCheck-request-Inverted\">Inverted</a>. </p> <p>Charges for a health check still apply when the health check is disabled. For more information, see <a href=\"http://aws.amazon.com/route53/pricing/\">Amazon Route 53 Pricing</a>.</p>"];
      health_threshold: Integer.t option
        [@ocaml.doc
          "<p>The number of child health checks that are associated with a <code>CALCULATED</code> health check that Amazon Route 53 must consider healthy for the <code>CALCULATED</code> health check to be considered healthy. To specify the child health checks that you want to associate with a <code>CALCULATED</code> health check, use the <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_UpdateHealthCheck.html#Route53-UpdateHealthCheck-request-ChildHealthChecks\">ChildHealthChecks</a> element.</p> <p>Note the following:</p> <ul> <li> <p>If you specify a number greater than the number of child health checks, Route 53 always considers this health check to be unhealthy.</p> </li> <li> <p>If you specify <code>0</code>, Route 53 always considers this health check to be healthy.</p> </li> </ul>"];
      child_health_checks: ChildHealthCheckList.t
        [@ocaml.doc
          "<p>(CALCULATED Health Checks Only) A complex type that contains one <code>ChildHealthCheck</code> element for each health check that you want to associate with a <code>CALCULATED</code> health check.</p>"];
      enable_s_n_i: Boolean.t option
        [@ocaml.doc
          "<p>Specify whether you want Amazon Route 53 to send the value of <code>FullyQualifiedDomainName</code> to the endpoint in the <code>client_hello</code> message during TLS negotiation. This allows the endpoint to respond to <code>HTTPS</code> health check requests with the applicable SSL/TLS certificate.</p> <p>Some endpoints require that <code>HTTPS</code> requests include the host name in the <code>client_hello</code> message. If you don't enable SNI, the status of the health check will be <code>SSL alert handshake_failure</code>. A health check can also have that status for other reasons. If SNI is enabled and you're still getting the error, check the SSL/TLS configuration on your endpoint and confirm that your certificate is valid.</p> <p>The SSL/TLS certificate on your endpoint includes a domain name in the <code>Common Name</code> field and possibly several more in the <code>Subject Alternative Names</code> field. One of the domain names in the certificate should match the value that you specify for <code>FullyQualifiedDomainName</code>. If the endpoint responds to the <code>client_hello</code> message with a certificate that does not include the domain name that you specified in <code>FullyQualifiedDomainName</code>, a health checker will retry the handshake. In the second attempt, the health checker will omit <code>FullyQualifiedDomainName</code> from the <code>client_hello</code> message.</p>"];
      regions: HealthCheckRegionList.t
        [@ocaml.doc
          "<p>A complex type that contains one <code>Region</code> element for each region from which you want Amazon Route 53 health checkers to check the specified endpoint.</p> <p>If you don't specify any regions, Route 53 health checkers automatically performs checks from all of the regions that are listed under <b>Valid Values</b>.</p> <p>If you update a health check to remove a region that has been performing health checks, Route 53 will briefly continue to perform checks from that region to ensure that some health checkers are always checking the endpoint (for example, if you replace three regions with four different regions). </p>"];
      alarm_identifier: AlarmIdentifier.t option
        [@ocaml.doc
          "<p>A complex type that identifies the CloudWatch alarm that you want Amazon Route 53 health checkers to use to determine whether the specified health check is healthy.</p>"];
      insufficient_data_health_status: InsufficientDataHealthStatus.t option
        [@ocaml.doc
          "<p>When CloudWatch has insufficient data about the metric to determine the alarm state, the status that you want Amazon Route 53 to assign to the health check:</p> <ul> <li> <p> <code>Healthy</code>: Route 53 considers the health check to be healthy.</p> </li> <li> <p> <code>Unhealthy</code>: Route 53 considers the health check to be unhealthy.</p> </li> <li> <p> <code>LastKnownStatus</code>: Route 53 uses the status of the health check from the last time that CloudWatch had sufficient data to determine the alarm state. For new health checks that have no last known status, the default status for the health check is healthy.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the health check.</p>"]
    let make ?i_p_address  ?port  ~type_  ?resource_path 
      ?fully_qualified_domain_name  ?search_string  ?request_interval 
      ?failure_threshold  ?measure_latency  ?inverted  ?disabled 
      ?health_threshold  ?(child_health_checks= [])  ?enable_s_n_i 
      ?(regions= [])  ?alarm_identifier  ?insufficient_data_health_status  ()
      =
      {
        i_p_address;
        port;
        type_;
        resource_path;
        fully_qualified_domain_name;
        search_string;
        request_interval;
        failure_threshold;
        measure_latency;
        inverted;
        disabled;
        health_threshold;
        child_health_checks;
        enable_s_n_i;
        regions;
        alarm_identifier;
        insufficient_data_health_status
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.insufficient_data_health_status
              (fun f ->
                 ("insufficient_data_health_status",
                   (InsufficientDataHealthStatus.to_json f)));
           Util.option_map v.alarm_identifier
             (fun f -> ("alarm_identifier", (AlarmIdentifier.to_json f)));
           Some ("regions", (HealthCheckRegionList.to_json v.regions));
           Util.option_map v.enable_s_n_i
             (fun f -> ("enable_s_n_i", (Boolean.to_json f)));
           Some
             ("child_health_checks",
               (ChildHealthCheckList.to_json v.child_health_checks));
           Util.option_map v.health_threshold
             (fun f -> ("health_threshold", (Integer.to_json f)));
           Util.option_map v.disabled
             (fun f -> ("disabled", (Boolean.to_json f)));
           Util.option_map v.inverted
             (fun f -> ("inverted", (Boolean.to_json f)));
           Util.option_map v.measure_latency
             (fun f -> ("measure_latency", (Boolean.to_json f)));
           Util.option_map v.failure_threshold
             (fun f -> ("failure_threshold", (Integer.to_json f)));
           Util.option_map v.request_interval
             (fun f -> ("request_interval", (Integer.to_json f)));
           Util.option_map v.search_string
             (fun f -> ("search_string", (String.to_json f)));
           Util.option_map v.fully_qualified_domain_name
             (fun f -> ("fully_qualified_domain_name", (String.to_json f)));
           Util.option_map v.resource_path
             (fun f -> ("resource_path", (String.to_json f)));
           Some ("type_", (HealthCheckType.to_json v.type_));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.i_p_address
             (fun f -> ("i_p_address", (String.to_json f)))])
    let parse xml =
      Some
        {
          i_p_address =
            (Util.option_bind (Xml.member "IPAddress" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml)
                  HealthCheckType.parse));
          resource_path =
            (Util.option_bind (Xml.member "ResourcePath" xml) String.parse);
          fully_qualified_domain_name =
            (Util.option_bind (Xml.member "FullyQualifiedDomainName" xml)
               String.parse);
          search_string =
            (Util.option_bind (Xml.member "SearchString" xml) String.parse);
          request_interval =
            (Util.option_bind (Xml.member "RequestInterval" xml)
               Integer.parse);
          failure_threshold =
            (Util.option_bind (Xml.member "FailureThreshold" xml)
               Integer.parse);
          measure_latency =
            (Util.option_bind (Xml.member "MeasureLatency" xml) Boolean.parse);
          inverted =
            (Util.option_bind (Xml.member "Inverted" xml) Boolean.parse);
          disabled =
            (Util.option_bind (Xml.member "Disabled" xml) Boolean.parse);
          health_threshold =
            (Util.option_bind (Xml.member "HealthThreshold" xml)
               Integer.parse);
          child_health_checks =
            (Util.of_option []
               (Util.option_bind (Xml.member "ChildHealthChecks" xml)
                  ChildHealthCheckList.parse));
          enable_s_n_i =
            (Util.option_bind (Xml.member "EnableSNI" xml) Boolean.parse);
          regions =
            (Util.of_option []
               (Util.option_bind (Xml.member "Regions" xml)
                  HealthCheckRegionList.parse));
          alarm_identifier =
            (Util.option_bind (Xml.member "AlarmIdentifier" xml)
               AlarmIdentifier.parse);
          insufficient_data_health_status =
            (Util.option_bind (Xml.member "InsufficientDataHealthStatus" xml)
               InsufficientDataHealthStatus.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((([] @
                           [Util.option_map v.i_p_address
                              (fun f ->
                                 Ezxmlm.make_tag "IPAddress"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.port
                             (fun f ->
                                Ezxmlm.make_tag "Port"
                                  ([], (Integer.to_xml f)))])
                         @
                         [Some
                            (Ezxmlm.make_tag "Type"
                               ([], (HealthCheckType.to_xml v.type_)))])
                        @
                        [Util.option_map v.resource_path
                           (fun f ->
                              Ezxmlm.make_tag "ResourcePath"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.fully_qualified_domain_name
                          (fun f ->
                             Ezxmlm.make_tag "FullyQualifiedDomainName"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.search_string
                         (fun f ->
                            Ezxmlm.make_tag "SearchString"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.request_interval
                        (fun f ->
                           Ezxmlm.make_tag "RequestInterval"
                             ([], (Integer.to_xml f)))])
                    @
                    [Util.option_map v.failure_threshold
                       (fun f ->
                          Ezxmlm.make_tag "FailureThreshold"
                            ([], (Integer.to_xml f)))])
                   @
                   [Util.option_map v.measure_latency
                      (fun f ->
                         Ezxmlm.make_tag "MeasureLatency"
                           ([], (Boolean.to_xml f)))])
                  @
                  [Util.option_map v.inverted
                     (fun f ->
                        Ezxmlm.make_tag "Inverted" ([], (Boolean.to_xml f)))])
                 @
                 [Util.option_map v.disabled
                    (fun f ->
                       Ezxmlm.make_tag "Disabled" ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.health_threshold
                   (fun f ->
                      Ezxmlm.make_tag "HealthThreshold"
                        ([], (Integer.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "ChildHealthChecks"
                          ([], (ChildHealthCheckList.to_xml [x]))))
                  v.child_health_checks))
              @
              [Util.option_map v.enable_s_n_i
                 (fun f ->
                    Ezxmlm.make_tag "EnableSNI" ([], (Boolean.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Regions"
                        ([], (HealthCheckRegionList.to_xml [x])))) v.regions))
            @
            [Util.option_map v.alarm_identifier
               (fun f ->
                  Ezxmlm.make_tag "AlarmIdentifier"
                    ([], (AlarmIdentifier.to_xml f)))])
           @
           [Util.option_map v.insufficient_data_health_status
              (fun f ->
                 Ezxmlm.make_tag "InsufficientDataHealthStatus"
                   ([], (InsufficientDataHealthStatus.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the health check.</p>"]
module TagList =
  struct
    type t = Tag.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_json v = `List (List.map Tag.to_json v)
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "Tag" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
  end
module TagResourceType =
  struct
    type t =
      | Healthcheck 
      | Hostedzone 
    let str_to_t = [("hostedzone", Hostedzone); ("healthcheck", Healthcheck)]
    let t_to_str = [(Hostedzone, "hostedzone"); (Healthcheck, "healthcheck")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module DelegationSetNameServers =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "NameServer" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module Change =
  struct
    type t =
      {
      action: ChangeAction.t
        [@ocaml.doc
          "<p>The action to perform:</p> <ul> <li> <p> <code>CREATE</code>: Creates a resource record set that has the specified values.</p> </li> <li> <p> <code>DELETE</code>: Deletes a existing resource record set.</p> <important> <p>To delete the resource record set that is associated with a traffic policy instance, use <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_DeleteTrafficPolicyInstance.html\">DeleteTrafficPolicyInstance</a>. Amazon Route 53 will delete the resource record set automatically. If you delete the resource record set by using <code>ChangeResourceRecordSets</code>, Route 53 doesn't automatically delete the traffic policy instance, and you'll continue to be charged for it even though it's no longer in use. </p> </important> </li> <li> <p> <code>UPSERT</code>: If a resource record set doesn't already exist, Route 53 creates it. If a resource record set does exist, Route 53 updates it with the values in the request.</p> </li> </ul>"];
      resource_record_set: ResourceRecordSet.t
        [@ocaml.doc
          "<p>Information about the resource record set to create, delete, or update.</p>"]}
    [@@ocaml.doc
      "<p>The information for each resource record set that you want to change.</p>"]
    let make ~action  ~resource_record_set  () =
      { action; resource_record_set }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("resource_record_set",
                (ResourceRecordSet.to_json v.resource_record_set));
           Some ("action", (ChangeAction.to_json v.action))])
    let parse xml =
      Some
        {
          action =
            (Xml.required "Action"
               (Util.option_bind (Xml.member "Action" xml) ChangeAction.parse));
          resource_record_set =
            (Xml.required "ResourceRecordSet"
               (Util.option_bind (Xml.member "ResourceRecordSet" xml)
                  ResourceRecordSet.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Action" ([], (ChangeAction.to_xml v.action)))])
           @
           [Some
              (Ezxmlm.make_tag "ResourceRecordSet"
                 ([], (ResourceRecordSet.to_xml v.resource_record_set)))])
  end[@@ocaml.doc
       "<p>The information for each resource record set that you want to change.</p>"]
module HostedZone =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID that Amazon Route 53 assigned to the hosted zone when you created it.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>The name of the domain. For public hosted zones, this is the name that you have registered with your DNS registrar.</p> <p>For information about how to specify characters other than <code>a-z</code>, <code>0-9</code>, and <code>-</code> (hyphen) and how to specify internationalized domain names, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateHostedZone.html\">CreateHostedZone</a>.</p>"];
      caller_reference: String.t
        [@ocaml.doc
          "<p>The value that you specified for <code>CallerReference</code> when you created the hosted zone.</p>"];
      config: HostedZoneConfig.t option
        [@ocaml.doc
          "<p>A complex type that includes the <code>Comment</code> and <code>PrivateZone</code> elements. If you omitted the <code>HostedZoneConfig</code> and <code>Comment</code> elements from the request, the <code>Config</code> and <code>Comment</code> elements don't appear in the response.</p>"];
      resource_record_set_count: Long.t option
        [@ocaml.doc
          "<p>The number of resource record sets in the hosted zone.</p>"];
      linked_service: LinkedService.t option
        [@ocaml.doc
          "<p>If the hosted zone was created by another service, the service that created the hosted zone. When a hosted zone is created by another service, you can't edit or delete it using Route 53. </p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains general information about the hosted zone.</p>"]
    let make ~id  ~name  ~caller_reference  ?config 
      ?resource_record_set_count  ?linked_service  () =
      {
        id;
        name;
        caller_reference;
        config;
        resource_record_set_count;
        linked_service
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.linked_service
              (fun f -> ("linked_service", (LinkedService.to_json f)));
           Util.option_map v.resource_record_set_count
             (fun f -> ("resource_record_set_count", (Long.to_json f)));
           Util.option_map v.config
             (fun f -> ("config", (HostedZoneConfig.to_json f)));
           Some ("caller_reference", (String.to_json v.caller_reference));
           Some ("name", (String.to_json v.name));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          caller_reference =
            (Xml.required "CallerReference"
               (Util.option_bind (Xml.member "CallerReference" xml)
                  String.parse));
          config =
            (Util.option_bind (Xml.member "Config" xml)
               HostedZoneConfig.parse);
          resource_record_set_count =
            (Util.option_bind (Xml.member "ResourceRecordSetCount" xml)
               Long.parse);
          linked_service =
            (Util.option_bind (Xml.member "LinkedService" xml)
               LinkedService.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
               @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
              @
              [Some
                 (Ezxmlm.make_tag "CallerReference"
                    ([], (String.to_xml v.caller_reference)))])
             @
             [Util.option_map v.config
                (fun f ->
                   Ezxmlm.make_tag "Config" ([], (HostedZoneConfig.to_xml f)))])
            @
            [Util.option_map v.resource_record_set_count
               (fun f ->
                  Ezxmlm.make_tag "ResourceRecordSetCount"
                    ([], (Long.to_xml f)))])
           @
           [Util.option_map v.linked_service
              (fun f ->
                 Ezxmlm.make_tag "LinkedService"
                   ([], (LinkedService.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains general information about the hosted zone.</p>"]
module ChangeStatus =
  struct
    type t =
      | PENDING 
      | INSYNC 
    let str_to_t = [("INSYNC", INSYNC); ("PENDING", PENDING)]
    let t_to_str = [(INSYNC, "INSYNC"); (PENDING, "PENDING")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module TrafficPolicy =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID that Amazon Route 53 assigned to a traffic policy when you created it.</p>"];
      version: Integer.t
        [@ocaml.doc
          "<p>The version number that Amazon Route 53 assigns to a traffic policy. For a new traffic policy, the value of <code>Version</code> is always 1.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>The name that you specified when you created the traffic policy.</p>"];
      type_: RRType.t
        [@ocaml.doc
          "<p>The DNS type of the resource record sets that Amazon Route 53 creates when you use a traffic policy to create a traffic policy instance.</p>"];
      document: String.t
        [@ocaml.doc
          "<p>The definition of a traffic policy in JSON format. You specify the JSON document to use for a new traffic policy in the <code>CreateTrafficPolicy</code> request. For more information about the JSON format, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/api-policies-traffic-policy-document-format.html\">Traffic Policy Document Format</a>.</p>"];
      comment: String.t option
        [@ocaml.doc
          "<p>The comment that you specify in the <code>CreateTrafficPolicy</code> request, if any.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains settings for a traffic policy.</p>"]
    let make ~id  ~version  ~name  ~type_  ~document  ?comment  () =
      { id; version; name; type_; document; comment }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.comment
              (fun f -> ("comment", (String.to_json f)));
           Some ("document", (String.to_json v.document));
           Some ("type_", (RRType.to_json v.type_));
           Some ("name", (String.to_json v.name));
           Some ("version", (Integer.to_json v.version));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          version =
            (Xml.required "Version"
               (Util.option_bind (Xml.member "Version" xml) Integer.parse));
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml) RRType.parse));
          document =
            (Xml.required "Document"
               (Util.option_bind (Xml.member "Document" xml) String.parse));
          comment =
            (Util.option_bind (Xml.member "Comment" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
               @
               [Some
                  (Ezxmlm.make_tag "Version" ([], (Integer.to_xml v.version)))])
              @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
             @ [Some (Ezxmlm.make_tag "Type" ([], (RRType.to_xml v.type_)))])
            @
            [Some
               (Ezxmlm.make_tag "Document" ([], (String.to_xml v.document)))])
           @
           [Util.option_map v.comment
              (fun f -> Ezxmlm.make_tag "Comment" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains settings for a traffic policy.</p>"]
module HealthCheckObservation =
  struct
    type t =
      {
      region: HealthCheckRegion.t option
        [@ocaml.doc
          "<p>The region of the Amazon Route 53 health checker that provided the status in <code>StatusReport</code>.</p>"];
      i_p_address: String.t option
        [@ocaml.doc
          "<p>The IP address of the Amazon Route 53 health checker that provided the failure reason in <code>StatusReport</code>.</p>"];
      status_report: StatusReport.t option
        [@ocaml.doc
          "<p>A complex type that contains the last failure reason as reported by one Amazon Route 53 health checker and the time of the failed health check.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the last failure reason as reported by one Amazon Route 53 health checker.</p>"]
    let make ?region  ?i_p_address  ?status_report  () =
      { region; i_p_address; status_report }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status_report
              (fun f -> ("status_report", (StatusReport.to_json f)));
           Util.option_map v.i_p_address
             (fun f -> ("i_p_address", (String.to_json f)));
           Util.option_map v.region
             (fun f -> ("region", (HealthCheckRegion.to_json f)))])
    let parse xml =
      Some
        {
          region =
            (Util.option_bind (Xml.member "Region" xml)
               HealthCheckRegion.parse);
          i_p_address =
            (Util.option_bind (Xml.member "IPAddress" xml) String.parse);
          status_report =
            (Util.option_bind (Xml.member "StatusReport" xml)
               StatusReport.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.region
                (fun f ->
                   Ezxmlm.make_tag "Region"
                     ([], (HealthCheckRegion.to_xml f)))])
            @
            [Util.option_map v.i_p_address
               (fun f -> Ezxmlm.make_tag "IPAddress" ([], (String.to_xml f)))])
           @
           [Util.option_map v.status_report
              (fun f ->
                 Ezxmlm.make_tag "StatusReport" ([], (StatusReport.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the last failure reason as reported by one Amazon Route 53 health checker.</p>"]
module TrafficPolicyInstance =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID that Amazon Route 53 assigned to the new traffic policy instance.</p>"];
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that Amazon Route 53 created resource record sets in.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>The DNS name, such as www.example.com, for which Amazon Route 53 responds to queries by using the resource record sets that are associated with this traffic policy instance. </p>"];
      t_t_l: Long.t
        [@ocaml.doc
          "<p>The TTL that Amazon Route 53 assigned to all of the resource record sets that it created in the specified hosted zone.</p>"];
      state: String.t
        [@ocaml.doc
          "<p>The value of <code>State</code> is one of the following values:</p> <dl> <dt>Applied</dt> <dd> <p>Amazon Route 53 has finished creating resource record sets, and changes have propagated to all Route 53 edge locations.</p> </dd> <dt>Creating</dt> <dd> <p>Route 53 is creating the resource record sets. Use <code>GetTrafficPolicyInstance</code> to confirm that the <code>CreateTrafficPolicyInstance</code> request completed successfully.</p> </dd> <dt>Failed</dt> <dd> <p>Route 53 wasn't able to create or update the resource record sets. When the value of <code>State</code> is <code>Failed</code>, see <code>Message</code> for an explanation of what caused the request to fail.</p> </dd> </dl>"];
      message: String.t
        [@ocaml.doc
          "<p>If <code>State</code> is <code>Failed</code>, an explanation of the reason for the failure. If <code>State</code> is another value, <code>Message</code> is empty.</p>"];
      traffic_policy_id: String.t
        [@ocaml.doc
          "<p>The ID of the traffic policy that Amazon Route 53 used to create resource record sets in the specified hosted zone.</p>"];
      traffic_policy_version: Integer.t
        [@ocaml.doc
          "<p>The version of the traffic policy that Amazon Route 53 used to create resource record sets in the specified hosted zone.</p>"];
      traffic_policy_type: RRType.t
        [@ocaml.doc
          "<p>The DNS type that Amazon Route 53 assigned to all of the resource record sets that it created for this traffic policy instance. </p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains settings for the new traffic policy instance.</p>"]
    let make ~id  ~hosted_zone_id  ~name  ~t_t_l  ~state  ~message 
      ~traffic_policy_id  ~traffic_policy_version  ~traffic_policy_type  () =
      {
        id;
        hosted_zone_id;
        name;
        t_t_l;
        state;
        message;
        traffic_policy_id;
        traffic_policy_version;
        traffic_policy_type
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("traffic_policy_type", (RRType.to_json v.traffic_policy_type));
           Some
             ("traffic_policy_version",
               (Integer.to_json v.traffic_policy_version));
           Some ("traffic_policy_id", (String.to_json v.traffic_policy_id));
           Some ("message", (String.to_json v.message));
           Some ("state", (String.to_json v.state));
           Some ("t_t_l", (Long.to_json v.t_t_l));
           Some ("name", (String.to_json v.name));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          hosted_zone_id =
            (Xml.required "HostedZoneId"
               (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse));
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          t_t_l =
            (Xml.required "TTL"
               (Util.option_bind (Xml.member "TTL" xml) Long.parse));
          state =
            (Xml.required "State"
               (Util.option_bind (Xml.member "State" xml) String.parse));
          message =
            (Xml.required "Message"
               (Util.option_bind (Xml.member "Message" xml) String.parse));
          traffic_policy_id =
            (Xml.required "TrafficPolicyId"
               (Util.option_bind (Xml.member "TrafficPolicyId" xml)
                  String.parse));
          traffic_policy_version =
            (Xml.required "TrafficPolicyVersion"
               (Util.option_bind (Xml.member "TrafficPolicyVersion" xml)
                  Integer.parse));
          traffic_policy_type =
            (Xml.required "TrafficPolicyType"
               (Util.option_bind (Xml.member "TrafficPolicyType" xml)
                  RRType.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "HostedZoneId"
                        ([], (String.to_xml v.hosted_zone_id)))])
                 @
                 [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
                @ [Some (Ezxmlm.make_tag "TTL" ([], (Long.to_xml v.t_t_l)))])
               @
               [Some (Ezxmlm.make_tag "State" ([], (String.to_xml v.state)))])
              @
              [Some
                 (Ezxmlm.make_tag "Message" ([], (String.to_xml v.message)))])
             @
             [Some
                (Ezxmlm.make_tag "TrafficPolicyId"
                   ([], (String.to_xml v.traffic_policy_id)))])
            @
            [Some
               (Ezxmlm.make_tag "TrafficPolicyVersion"
                  ([], (Integer.to_xml v.traffic_policy_version)))])
           @
           [Some
              (Ezxmlm.make_tag "TrafficPolicyType"
                 ([], (RRType.to_xml v.traffic_policy_type)))])
  end[@@ocaml.doc
       "<p>A complex type that contains settings for the new traffic policy instance.</p>"]
module ResettableElementName =
  struct
    type t =
      | FullyQualifiedDomainName 
      | Regions 
      | ResourcePath 
      | ChildHealthChecks 
    let str_to_t =
      [("ChildHealthChecks", ChildHealthChecks);
      ("ResourcePath", ResourcePath);
      ("Regions", Regions);
      ("FullyQualifiedDomainName", FullyQualifiedDomainName)]
    let t_to_str =
      [(ChildHealthChecks, "ChildHealthChecks");
      (ResourcePath, "ResourcePath");
      (Regions, "Regions");
      (FullyQualifiedDomainName, "FullyQualifiedDomainName")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module VPC =
  struct
    type t =
      {
      v_p_c_region: VPCRegion.t option
        [@ocaml.doc
          "<p>(Private hosted zones only) The region that an Amazon VPC was created in.</p>"];
      v_p_c_id: String.t option }[@@ocaml.doc
                                   "<p>(Private hosted zones only) A complex type that contains information about an Amazon VPC.</p>"]
    let make ?v_p_c_region  ?v_p_c_id  () = { v_p_c_region; v_p_c_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.v_p_c_id
              (fun f -> ("v_p_c_id", (String.to_json f)));
           Util.option_map v.v_p_c_region
             (fun f -> ("v_p_c_region", (VPCRegion.to_json f)))])
    let parse xml =
      Some
        {
          v_p_c_region =
            (Util.option_bind (Xml.member "VPCRegion" xml) VPCRegion.parse);
          v_p_c_id = (Util.option_bind (Xml.member "VPCId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.v_p_c_region
               (fun f ->
                  Ezxmlm.make_tag "VPCRegion" ([], (VPCRegion.to_xml f)))])
           @
           [Util.option_map v.v_p_c_id
              (fun f -> Ezxmlm.make_tag "VPCId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>(Private hosted zones only) A complex type that contains information about an Amazon VPC.</p>"]
module GeoLocationDetails =
  struct
    type t =
      {
      continent_code: String.t option
        [@ocaml.doc "<p>The two-letter code for the continent.</p>"];
      continent_name: String.t option
        [@ocaml.doc "<p>The full name of the continent.</p>"];
      country_code: String.t option
        [@ocaml.doc "<p>The two-letter code for the country.</p>"];
      country_name: String.t option
        [@ocaml.doc "<p>The name of the country.</p>"];
      subdivision_code: String.t option
        [@ocaml.doc
          "<p>The code for the subdivision. Route 53 currently supports only states in the United States.</p>"];
      subdivision_name: String.t option
        [@ocaml.doc
          "<p>The full name of the subdivision. Route 53 currently supports only states in the United States.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the codes and full continent, country, and subdivision names for the specified <code>geolocation</code> code.</p>"]
    let make ?continent_code  ?continent_name  ?country_code  ?country_name 
      ?subdivision_code  ?subdivision_name  () =
      {
        continent_code;
        continent_name;
        country_code;
        country_name;
        subdivision_code;
        subdivision_name
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.subdivision_name
              (fun f -> ("subdivision_name", (String.to_json f)));
           Util.option_map v.subdivision_code
             (fun f -> ("subdivision_code", (String.to_json f)));
           Util.option_map v.country_name
             (fun f -> ("country_name", (String.to_json f)));
           Util.option_map v.country_code
             (fun f -> ("country_code", (String.to_json f)));
           Util.option_map v.continent_name
             (fun f -> ("continent_name", (String.to_json f)));
           Util.option_map v.continent_code
             (fun f -> ("continent_code", (String.to_json f)))])
    let parse xml =
      Some
        {
          continent_code =
            (Util.option_bind (Xml.member "ContinentCode" xml) String.parse);
          continent_name =
            (Util.option_bind (Xml.member "ContinentName" xml) String.parse);
          country_code =
            (Util.option_bind (Xml.member "CountryCode" xml) String.parse);
          country_name =
            (Util.option_bind (Xml.member "CountryName" xml) String.parse);
          subdivision_code =
            (Util.option_bind (Xml.member "SubdivisionCode" xml) String.parse);
          subdivision_name =
            (Util.option_bind (Xml.member "SubdivisionName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.continent_code
                   (fun f ->
                      Ezxmlm.make_tag "ContinentCode" ([], (String.to_xml f)))])
               @
               [Util.option_map v.continent_name
                  (fun f ->
                     Ezxmlm.make_tag "ContinentName" ([], (String.to_xml f)))])
              @
              [Util.option_map v.country_code
                 (fun f ->
                    Ezxmlm.make_tag "CountryCode" ([], (String.to_xml f)))])
             @
             [Util.option_map v.country_name
                (fun f ->
                   Ezxmlm.make_tag "CountryName" ([], (String.to_xml f)))])
            @
            [Util.option_map v.subdivision_code
               (fun f ->
                  Ezxmlm.make_tag "SubdivisionCode" ([], (String.to_xml f)))])
           @
           [Util.option_map v.subdivision_name
              (fun f ->
                 Ezxmlm.make_tag "SubdivisionName" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the codes and full continent, country, and subdivision names for the specified <code>geolocation</code> code.</p>"]
module HostedZoneLimitType =
  struct
    type t =
      | MAX_RRSETS_BY_ZONE 
      | MAX_VPCS_ASSOCIATED_BY_ZONE 
    let str_to_t =
      [("MAX_VPCS_ASSOCIATED_BY_ZONE", MAX_VPCS_ASSOCIATED_BY_ZONE);
      ("MAX_RRSETS_BY_ZONE", MAX_RRSETS_BY_ZONE)]
    let t_to_str =
      [(MAX_VPCS_ASSOCIATED_BY_ZONE, "MAX_VPCS_ASSOCIATED_BY_ZONE");
      (MAX_RRSETS_BY_ZONE, "MAX_RRSETS_BY_ZONE")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module HealthCheck =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The identifier that Amazon Route 53assigned to the health check when you created it. When you add or update a resource record set, you use this value to specify which health check to use. The value can be up to 64 characters long. </p>"];
      caller_reference: String.t
        [@ocaml.doc
          "<p>A unique string that you specified when you created the health check.</p>"];
      linked_service: LinkedService.t option
        [@ocaml.doc
          "<p>If the health check was created by another service, the service that created the health check. When a health check is created by another service, you can't edit or delete it using Amazon Route 53. </p>"];
      health_check_config: HealthCheckConfig.t
        [@ocaml.doc
          "<p>A complex type that contains detailed information about one health check.</p>"];
      health_check_version: Long.t
        [@ocaml.doc
          "<p>The version of the health check. You can optionally pass this value in a call to <code>UpdateHealthCheck</code> to prevent overwriting another change to the health check.</p>"];
      cloud_watch_alarm_configuration: CloudWatchAlarmConfiguration.t option
        [@ocaml.doc
          "<p>A complex type that contains information about the CloudWatch alarm that Amazon Route 53 is monitoring for this health check.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about one health check that is associated with the current AWS account.</p>"]
    let make ~id  ~caller_reference  ?linked_service  ~health_check_config 
      ~health_check_version  ?cloud_watch_alarm_configuration  () =
      {
        id;
        caller_reference;
        linked_service;
        health_check_config;
        health_check_version;
        cloud_watch_alarm_configuration
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cloud_watch_alarm_configuration
              (fun f ->
                 ("cloud_watch_alarm_configuration",
                   (CloudWatchAlarmConfiguration.to_json f)));
           Some
             ("health_check_version", (Long.to_json v.health_check_version));
           Some
             ("health_check_config",
               (HealthCheckConfig.to_json v.health_check_config));
           Util.option_map v.linked_service
             (fun f -> ("linked_service", (LinkedService.to_json f)));
           Some ("caller_reference", (String.to_json v.caller_reference));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          caller_reference =
            (Xml.required "CallerReference"
               (Util.option_bind (Xml.member "CallerReference" xml)
                  String.parse));
          linked_service =
            (Util.option_bind (Xml.member "LinkedService" xml)
               LinkedService.parse);
          health_check_config =
            (Xml.required "HealthCheckConfig"
               (Util.option_bind (Xml.member "HealthCheckConfig" xml)
                  HealthCheckConfig.parse));
          health_check_version =
            (Xml.required "HealthCheckVersion"
               (Util.option_bind (Xml.member "HealthCheckVersion" xml)
                  Long.parse));
          cloud_watch_alarm_configuration =
            (Util.option_bind (Xml.member "CloudWatchAlarmConfiguration" xml)
               CloudWatchAlarmConfiguration.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
               @
               [Some
                  (Ezxmlm.make_tag "CallerReference"
                     ([], (String.to_xml v.caller_reference)))])
              @
              [Util.option_map v.linked_service
                 (fun f ->
                    Ezxmlm.make_tag "LinkedService"
                      ([], (LinkedService.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "HealthCheckConfig"
                   ([], (HealthCheckConfig.to_xml v.health_check_config)))])
            @
            [Some
               (Ezxmlm.make_tag "HealthCheckVersion"
                  ([], (Long.to_xml v.health_check_version)))])
           @
           [Util.option_map v.cloud_watch_alarm_configuration
              (fun f ->
                 Ezxmlm.make_tag "CloudWatchAlarmConfiguration"
                   ([], (CloudWatchAlarmConfiguration.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about one health check that is associated with the current AWS account.</p>"]
module QueryLoggingConfig =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID for a configuration for DNS query logging.</p>"];
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that CloudWatch Logs is logging queries for. </p>"];
      cloud_watch_logs_log_group_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the CloudWatch Logs log group that Amazon Route 53 is publishing logs to.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about a configuration for DNS query logging.</p>"]
    let make ~id  ~hosted_zone_id  ~cloud_watch_logs_log_group_arn  () =
      { id; hosted_zone_id; cloud_watch_logs_log_group_arn }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cloud_watch_logs_log_group_arn",
                (String.to_json v.cloud_watch_logs_log_group_arn));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          hosted_zone_id =
            (Xml.required "HostedZoneId"
               (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse));
          cloud_watch_logs_log_group_arn =
            (Xml.required "CloudWatchLogsLogGroupArn"
               (Util.option_bind (Xml.member "CloudWatchLogsLogGroupArn" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
            [Some
               (Ezxmlm.make_tag "HostedZoneId"
                  ([], (String.to_xml v.hosted_zone_id)))])
           @
           [Some
              (Ezxmlm.make_tag "CloudWatchLogsLogGroupArn"
                 ([], (String.to_xml v.cloud_watch_logs_log_group_arn)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about a configuration for DNS query logging.</p>"]
module ResourceTagSet =
  struct
    type t =
      {
      resource_type: TagResourceType.t option
        [@ocaml.doc
          "<p>The type of the resource.</p> <ul> <li> <p>The resource type for health checks is <code>healthcheck</code>.</p> </li> <li> <p>The resource type for hosted zones is <code>hostedzone</code>.</p> </li> </ul>"];
      resource_id: String.t option
        [@ocaml.doc "<p>The ID for the specified resource.</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>The tags associated with the specified resource.</p>"]}
    [@@ocaml.doc
      "<p>A complex type containing a resource and its associated tags.</p>"]
    let make ?resource_type  ?resource_id  ?(tags= [])  () =
      { resource_type; resource_id; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.resource_id
             (fun f -> ("resource_id", (String.to_json f)));
           Util.option_map v.resource_type
             (fun f -> ("resource_type", (TagResourceType.to_json f)))])
    let parse xml =
      Some
        {
          resource_type =
            (Util.option_bind (Xml.member "ResourceType" xml)
               TagResourceType.parse);
          resource_id =
            (Util.option_bind (Xml.member "ResourceId" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.resource_type
                (fun f ->
                   Ezxmlm.make_tag "ResourceType"
                     ([], (TagResourceType.to_xml f)))])
            @
            [Util.option_map v.resource_id
               (fun f -> Ezxmlm.make_tag "ResourceId" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc
       "<p>A complex type containing a resource and its associated tags.</p>"]
module AccountLimitType =
  struct
    type t =
      | MAX_HEALTH_CHECKS_BY_OWNER 
      | MAX_HOSTED_ZONES_BY_OWNER 
      | MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER 
      | MAX_REUSABLE_DELEGATION_SETS_BY_OWNER 
      | MAX_TRAFFIC_POLICIES_BY_OWNER 
    let str_to_t =
      [("MAX_TRAFFIC_POLICIES_BY_OWNER", MAX_TRAFFIC_POLICIES_BY_OWNER);
      ("MAX_REUSABLE_DELEGATION_SETS_BY_OWNER",
        MAX_REUSABLE_DELEGATION_SETS_BY_OWNER);
      ("MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER",
        MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER);
      ("MAX_HOSTED_ZONES_BY_OWNER", MAX_HOSTED_ZONES_BY_OWNER);
      ("MAX_HEALTH_CHECKS_BY_OWNER", MAX_HEALTH_CHECKS_BY_OWNER)]
    let t_to_str =
      [(MAX_TRAFFIC_POLICIES_BY_OWNER, "MAX_TRAFFIC_POLICIES_BY_OWNER");
      (MAX_REUSABLE_DELEGATION_SETS_BY_OWNER,
        "MAX_REUSABLE_DELEGATION_SETS_BY_OWNER");
      (MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER,
        "MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER");
      (MAX_HOSTED_ZONES_BY_OWNER, "MAX_HOSTED_ZONES_BY_OWNER");
      (MAX_HEALTH_CHECKS_BY_OWNER, "MAX_HEALTH_CHECKS_BY_OWNER")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ReusableDelegationSetLimitType =
  struct
    type t =
      | MAX_ZONES_BY_REUSABLE_DELEGATION_SET 
    let str_to_t =
      [("MAX_ZONES_BY_REUSABLE_DELEGATION_SET",
         MAX_ZONES_BY_REUSABLE_DELEGATION_SET)]
    let t_to_str =
      [(MAX_ZONES_BY_REUSABLE_DELEGATION_SET,
         "MAX_ZONES_BY_REUSABLE_DELEGATION_SET")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module DelegationSet =
  struct
    type t =
      {
      id: String.t option
        [@ocaml.doc
          "<p>The ID that Amazon Route 53 assigns to a reusable delegation set.</p>"];
      caller_reference: String.t option
        [@ocaml.doc
          "<p>The value that you specified for <code>CallerReference</code> when you created the reusable delegation set.</p>"];
      name_servers: DelegationSetNameServers.t
        [@ocaml.doc
          "<p>A complex type that contains a list of the authoritative name servers for a hosted zone or for a reusable delegation set.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that lists the name servers in a delegation set, as well as the <code>CallerReference</code> and the <code>ID</code> for the delegation set.</p>"]
    let make ?id  ?caller_reference  ~name_servers  () =
      { id; caller_reference; name_servers }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("name_servers",
                (DelegationSetNameServers.to_json v.name_servers));
           Util.option_map v.caller_reference
             (fun f -> ("caller_reference", (String.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          caller_reference =
            (Util.option_bind (Xml.member "CallerReference" xml) String.parse);
          name_servers =
            (Xml.required "NameServers"
               (Util.option_bind (Xml.member "NameServers" xml)
                  DelegationSetNameServers.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.id
                (fun f -> Ezxmlm.make_tag "Id" ([], (String.to_xml f)))])
            @
            [Util.option_map v.caller_reference
               (fun f ->
                  Ezxmlm.make_tag "CallerReference" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "NameServers"
                      ([], (DelegationSetNameServers.to_xml [x]))))
              v.name_servers))
  end[@@ocaml.doc
       "<p>A complex type that lists the name servers in a delegation set, as well as the <code>CallerReference</code> and the <code>ID</code> for the delegation set.</p>"]
module TrafficPolicySummary =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID that Amazon Route 53 assigned to the traffic policy when you created it.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>The name that you specified for the traffic policy when you created it.</p>"];
      type_: RRType.t
        [@ocaml.doc
          "<p>The DNS type of the resource record sets that Amazon Route 53 creates when you use a traffic policy to create a traffic policy instance.</p>"];
      latest_version: Integer.t
        [@ocaml.doc
          "<p>The version number of the latest version of the traffic policy.</p>"];
      traffic_policy_count: Integer.t
        [@ocaml.doc
          "<p>The number of traffic policies that are associated with the current AWS account.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the latest version of one traffic policy that is associated with the current AWS account.</p>"]
    let make ~id  ~name  ~type_  ~latest_version  ~traffic_policy_count  () =
      { id; name; type_; latest_version; traffic_policy_count }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("traffic_policy_count",
                (Integer.to_json v.traffic_policy_count));
           Some ("latest_version", (Integer.to_json v.latest_version));
           Some ("type_", (RRType.to_json v.type_));
           Some ("name", (String.to_json v.name));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml) RRType.parse));
          latest_version =
            (Xml.required "LatestVersion"
               (Util.option_bind (Xml.member "LatestVersion" xml)
                  Integer.parse));
          traffic_policy_count =
            (Xml.required "TrafficPolicyCount"
               (Util.option_bind (Xml.member "TrafficPolicyCount" xml)
                  Integer.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
              [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
             @ [Some (Ezxmlm.make_tag "Type" ([], (RRType.to_xml v.type_)))])
            @
            [Some
               (Ezxmlm.make_tag "LatestVersion"
                  ([], (Integer.to_xml v.latest_version)))])
           @
           [Some
              (Ezxmlm.make_tag "TrafficPolicyCount"
                 ([], (Integer.to_xml v.traffic_policy_count)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the latest version of one traffic policy that is associated with the current AWS account.</p>"]
module Changes =
  struct
    type t = Change.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Change.to_query v
    let to_headers v = Headers.to_headers_list Change.to_headers v
    let to_json v = `List (List.map Change.to_json v)
    let parse xml =
      Util.option_all (List.map Change.parse (Xml.members "Change" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Change.to_xml x))) v
  end
module HostedZones =
  struct
    type t = HostedZone.t list
    let make elems () = elems
    let to_query v = Query.to_query_list HostedZone.to_query v
    let to_headers v = Headers.to_headers_list HostedZone.to_headers v
    let to_json v = `List (List.map HostedZone.to_json v)
    let parse xml =
      Util.option_all
        (List.map HostedZone.parse (Xml.members "HostedZone" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (HostedZone.to_xml x))) v
  end
module ChangeInfo =
  struct
    type t =
      {
      id: String.t [@ocaml.doc "<p>The ID of the request.</p>"];
      status: ChangeStatus.t
        [@ocaml.doc
          "<p>The current state of the request. <code>PENDING</code> indicates that this request has not yet been applied to all Amazon Route 53 DNS servers.</p>"];
      submitted_at: DateTime.t
        [@ocaml.doc
          "<p>The date and time that the change request was submitted in <a href=\"https://en.wikipedia.org/wiki/ISO_8601\">ISO 8601 format</a> and Coordinated Universal Time (UTC). For example, the value <code>2017-03-27T17:48:16.751Z</code> represents March 27, 2017 at 17:48:16.751 UTC.</p>"];
      comment: String.t option
        [@ocaml.doc
          "<p>A complex type that describes change information about changes made to your hosted zone.</p> <p>This element contains an ID that you use when performing a <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetChange.html\">GetChange</a> action to get detailed information about the change.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that describes change information about changes made to your hosted zone.</p>"]
    let make ~id  ~status  ~submitted_at  ?comment  () =
      { id; status; submitted_at; comment }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.comment
              (fun f -> ("comment", (String.to_json f)));
           Some ("submitted_at", (DateTime.to_json v.submitted_at));
           Some ("status", (ChangeStatus.to_json v.status));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml) ChangeStatus.parse));
          submitted_at =
            (Xml.required "SubmittedAt"
               (Util.option_bind (Xml.member "SubmittedAt" xml)
                  DateTime.parse));
          comment =
            (Util.option_bind (Xml.member "Comment" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
             [Some
                (Ezxmlm.make_tag "Status"
                   ([], (ChangeStatus.to_xml v.status)))])
            @
            [Some
               (Ezxmlm.make_tag "SubmittedAt"
                  ([], (DateTime.to_xml v.submitted_at)))])
           @
           [Util.option_map v.comment
              (fun f -> Ezxmlm.make_tag "Comment" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that describes change information about changes made to your hosted zone.</p>"]
module TrafficPolicies =
  struct
    type t = TrafficPolicy.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TrafficPolicy.to_query v
    let to_headers v = Headers.to_headers_list TrafficPolicy.to_headers v
    let to_json v = `List (List.map TrafficPolicy.to_json v)
    let parse xml =
      Util.option_all
        (List.map TrafficPolicy.parse (Xml.members "TrafficPolicy" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (TrafficPolicy.to_xml x))) v
  end
module HealthCheckObservations =
  struct
    type t = HealthCheckObservation.t list
    let make elems () = elems
    let to_query v = Query.to_query_list HealthCheckObservation.to_query v
    let to_headers v =
      Headers.to_headers_list HealthCheckObservation.to_headers v
    let to_json v = `List (List.map HealthCheckObservation.to_json v)
    let parse xml =
      Util.option_all
        (List.map HealthCheckObservation.parse
           (Xml.members "HealthCheckObservation" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (HealthCheckObservation.to_xml x)))
        v
  end
module CheckerIpRanges =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module TrafficPolicyInstances =
  struct
    type t = TrafficPolicyInstance.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TrafficPolicyInstance.to_query v
    let to_headers v =
      Headers.to_headers_list TrafficPolicyInstance.to_headers v
    let to_json v = `List (List.map TrafficPolicyInstance.to_json v)
    let parse xml =
      Util.option_all
        (List.map TrafficPolicyInstance.parse
           (Xml.members "TrafficPolicyInstance" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (TrafficPolicyInstance.to_xml x))) v
  end
module ResettableElementNameList =
  struct
    type t = ResettableElementName.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResettableElementName.to_query v
    let to_headers v =
      Headers.to_headers_list ResettableElementName.to_headers v
    let to_json v = `List (List.map ResettableElementName.to_json v)
    let parse xml =
      Util.option_all
        (List.map ResettableElementName.parse
           (Xml.members "ResettableElementName" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ResettableElementName.to_xml x))) v
  end
module VPCs =
  struct
    type t = VPC.t list[@@ocaml.doc
                         "<p>(Private hosted zones only) A list of <code>VPC</code> elements.</p>"]
    let make elems () = elems
    let to_query v = Query.to_query_list VPC.to_query v
    let to_headers v = Headers.to_headers_list VPC.to_headers v
    let to_json v = `List (List.map VPC.to_json v)
    let parse xml =
      Util.option_all (List.map VPC.parse (Xml.members "VPC" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (VPC.to_xml x))) v
  end[@@ocaml.doc
       "<p>(Private hosted zones only) A list of <code>VPC</code> elements.</p>"]
module TagResourceIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "ResourceId" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module GeoLocationDetailsList =
  struct
    type t = GeoLocationDetails.t list
    let make elems () = elems
    let to_query v = Query.to_query_list GeoLocationDetails.to_query v
    let to_headers v =
      Headers.to_headers_list GeoLocationDetails.to_headers v
    let to_json v = `List (List.map GeoLocationDetails.to_json v)
    let parse xml =
      Util.option_all
        (List.map GeoLocationDetails.parse
           (Xml.members "GeoLocationDetails" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (GeoLocationDetails.to_xml x))) v
  end
module HostedZoneLimit =
  struct
    type t =
      {
      type_: HostedZoneLimitType.t
        [@ocaml.doc
          "<p>The limit that you requested. Valid values include the following:</p> <ul> <li> <p> <b>MAX_RRSETS_BY_ZONE</b>: The maximum number of records that you can create in the specified hosted zone.</p> </li> <li> <p> <b>MAX_VPCS_ASSOCIATED_BY_ZONE</b>: The maximum number of Amazon VPCs that you can associate with the specified private hosted zone.</p> </li> </ul>"];
      value: Long.t
        [@ocaml.doc
          "<p>The current value for the limit that is specified by <code>Type</code>.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the type of limit that you specified in the request and the current value for that limit.</p>"]
    let make ~type_  ~value  () = { type_; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (Long.to_json v.value));
           Some ("type_", (HostedZoneLimitType.to_json v.type_))])
    let parse xml =
      Some
        {
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml)
                  HostedZoneLimitType.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) Long.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Type"
                  ([], (HostedZoneLimitType.to_xml v.type_)))])
           @ [Some (Ezxmlm.make_tag "Value" ([], (Long.to_xml v.value)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the type of limit that you specified in the request and the current value for that limit.</p>"]
module HealthChecks =
  struct
    type t = HealthCheck.t list
    let make elems () = elems
    let to_query v = Query.to_query_list HealthCheck.to_query v
    let to_headers v = Headers.to_headers_list HealthCheck.to_headers v
    let to_json v = `List (List.map HealthCheck.to_json v)
    let parse xml =
      Util.option_all
        (List.map HealthCheck.parse (Xml.members "HealthCheck" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (HealthCheck.to_xml x))) v
  end
module QueryLoggingConfigs =
  struct
    type t = QueryLoggingConfig.t list
    let make elems () = elems
    let to_query v = Query.to_query_list QueryLoggingConfig.to_query v
    let to_headers v =
      Headers.to_headers_list QueryLoggingConfig.to_headers v
    let to_json v = `List (List.map QueryLoggingConfig.to_json v)
    let parse xml =
      Util.option_all
        (List.map QueryLoggingConfig.parse
           (Xml.members "QueryLoggingConfig" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (QueryLoggingConfig.to_xml x))) v
  end
module TagKeyList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "Key" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ResourceTagSetList =
  struct
    type t = ResourceTagSet.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResourceTagSet.to_query v
    let to_headers v = Headers.to_headers_list ResourceTagSet.to_headers v
    let to_json v = `List (List.map ResourceTagSet.to_json v)
    let parse xml =
      Util.option_all
        (List.map ResourceTagSet.parse (Xml.members "ResourceTagSet" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ResourceTagSet.to_xml x))) v
  end
module AccountLimit =
  struct
    type t =
      {
      type_: AccountLimitType.t
        [@ocaml.doc
          "<p>The limit that you requested. Valid values include the following:</p> <ul> <li> <p> <b>MAX_HEALTH_CHECKS_BY_OWNER</b>: The maximum number of health checks that you can create using the current account.</p> </li> <li> <p> <b>MAX_HOSTED_ZONES_BY_OWNER</b>: The maximum number of hosted zones that you can create using the current account.</p> </li> <li> <p> <b>MAX_REUSABLE_DELEGATION_SETS_BY_OWNER</b>: The maximum number of reusable delegation sets that you can create using the current account.</p> </li> <li> <p> <b>MAX_TRAFFIC_POLICIES_BY_OWNER</b>: The maximum number of traffic policies that you can create using the current account.</p> </li> <li> <p> <b>MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER</b>: The maximum number of traffic policy instances that you can create using the current account. (Traffic policy instances are referred to as traffic flow policy records in the Amazon Route 53 console.)</p> </li> </ul>"];
      value: Long.t
        [@ocaml.doc
          "<p>The current value for the limit that is specified by <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_AccountLimit.html#Route53-Type-AccountLimit-Type\">Type</a>.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the type of limit that you specified in the request and the current value for that limit.</p>"]
    let make ~type_  ~value  () = { type_; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (Long.to_json v.value));
           Some ("type_", (AccountLimitType.to_json v.type_))])
    let parse xml =
      Some
        {
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml)
                  AccountLimitType.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) Long.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Type"
                  ([], (AccountLimitType.to_xml v.type_)))])
           @ [Some (Ezxmlm.make_tag "Value" ([], (Long.to_xml v.value)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the type of limit that you specified in the request and the current value for that limit.</p>"]
module ResourceRecordSets =
  struct
    type t = ResourceRecordSet.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResourceRecordSet.to_query v
    let to_headers v = Headers.to_headers_list ResourceRecordSet.to_headers v
    let to_json v = `List (List.map ResourceRecordSet.to_json v)
    let parse xml =
      Util.option_all
        (List.map ResourceRecordSet.parse
           (Xml.members "ResourceRecordSet" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ResourceRecordSet.to_xml x)))
        v
  end
module ReusableDelegationSetLimit =
  struct
    type t =
      {
      type_: ReusableDelegationSetLimitType.t
        [@ocaml.doc
          "<p>The limit that you requested: <code>MAX_ZONES_BY_REUSABLE_DELEGATION_SET</code>, the maximum number of hosted zones that you can associate with the specified reusable delegation set.</p>"];
      value: Long.t
        [@ocaml.doc
          "<p>The current value for the <code>MAX_ZONES_BY_REUSABLE_DELEGATION_SET</code> limit.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the type of limit that you specified in the request and the current value for that limit.</p>"]
    let make ~type_  ~value  () = { type_; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (Long.to_json v.value));
           Some ("type_", (ReusableDelegationSetLimitType.to_json v.type_))])
    let parse xml =
      Some
        {
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml)
                  ReusableDelegationSetLimitType.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) Long.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Type"
                  ([], (ReusableDelegationSetLimitType.to_xml v.type_)))])
           @ [Some (Ezxmlm.make_tag "Value" ([], (Long.to_xml v.value)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the type of limit that you specified in the request and the current value for that limit.</p>"]
module DelegationSets =
  struct
    type t = DelegationSet.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DelegationSet.to_query v
    let to_headers v = Headers.to_headers_list DelegationSet.to_headers v
    let to_json v = `List (List.map DelegationSet.to_json v)
    let parse xml =
      Util.option_all
        (List.map DelegationSet.parse (Xml.members "DelegationSet" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DelegationSet.to_xml x))) v
  end
module TrafficPolicySummaries =
  struct
    type t = TrafficPolicySummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TrafficPolicySummary.to_query v
    let to_headers v =
      Headers.to_headers_list TrafficPolicySummary.to_headers v
    let to_json v = `List (List.map TrafficPolicySummary.to_json v)
    let parse xml =
      Util.option_all
        (List.map TrafficPolicySummary.parse
           (Xml.members "TrafficPolicySummary" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (TrafficPolicySummary.to_xml x))) v
  end
module ChangeBatch =
  struct
    type t =
      {
      comment: String.t option
        [@ocaml.doc
          "<p> <i>Optional:</i> Any comments you want to include about a change batch request.</p>"];
      changes: Changes.t
        [@ocaml.doc
          "<p>Information about the changes to make to the record sets.</p>"]}
    [@@ocaml.doc "<p>The information for a change request.</p>"]
    let make ?comment  ~changes  () = { comment; changes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("changes", (Changes.to_json v.changes));
           Util.option_map v.comment
             (fun f -> ("comment", (String.to_json f)))])
    let parse xml =
      Some
        {
          comment =
            (Util.option_bind (Xml.member "Comment" xml) String.parse);
          changes =
            (Xml.required "Changes"
               (Util.option_bind (Xml.member "Changes" xml) Changes.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.comment
               (fun f -> Ezxmlm.make_tag "Comment" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Changes" ([], (Changes.to_xml [x]))))
              v.changes))
  end[@@ocaml.doc "<p>The information for a change request.</p>"]
module RecordData =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "RecordDataEntry" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ListHostedZonesByNameResponse =
  struct
    type t =
      {
      hosted_zones: HostedZones.t
        [@ocaml.doc
          "<p>A complex type that contains general information about the hosted zone.</p>"];
      d_n_s_name: String.t option
        [@ocaml.doc
          "<p>For the second and subsequent calls to <code>ListHostedZonesByName</code>, <code>DNSName</code> is the value that you specified for the <code>dnsname</code> parameter in the request that produced the current response.</p>"];
      hosted_zone_id: String.t option
        [@ocaml.doc
          "<p>The ID that Amazon Route 53 assigned to the hosted zone when you created it.</p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A flag that indicates whether there are more hosted zones to be listed. If the response was truncated, you can get the next group of <code>maxitems</code> hosted zones by calling <code>ListHostedZonesByName</code> again and specifying the values of <code>NextDNSName</code> and <code>NextHostedZoneId</code> elements in the <code>dnsname</code> and <code>hostedzoneid</code> parameters.</p>"];
      next_d_n_s_name: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is true, the value of <code>NextDNSName</code> is the name of the first hosted zone in the next group of <code>maxitems</code> hosted zones. Call <code>ListHostedZonesByName</code> again and specify the value of <code>NextDNSName</code> and <code>NextHostedZoneId</code> in the <code>dnsname</code> and <code>hostedzoneid</code> parameters, respectively.</p> <p>This element is present only if <code>IsTruncated</code> is <code>true</code>.</p>"];
      next_hosted_zone_id: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, the value of <code>NextHostedZoneId</code> identifies the first hosted zone in the next group of <code>maxitems</code> hosted zones. Call <code>ListHostedZonesByName</code> again and specify the value of <code>NextDNSName</code> and <code>NextHostedZoneId</code> in the <code>dnsname</code> and <code>hostedzoneid</code> parameters, respectively.</p> <p>This element is present only if <code>IsTruncated</code> is <code>true</code>.</p>"];
      max_items: String.t
        [@ocaml.doc
          "<p>The value that you specified for the <code>maxitems</code> parameter in the call to <code>ListHostedZonesByName</code> that produced the current response.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the request.</p>"]
    let make ~hosted_zones  ?d_n_s_name  ?hosted_zone_id  ~is_truncated 
      ?next_d_n_s_name  ?next_hosted_zone_id  ~max_items  () =
      {
        hosted_zones;
        d_n_s_name;
        hosted_zone_id;
        is_truncated;
        next_d_n_s_name;
        next_hosted_zone_id;
        max_items
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Util.option_map v.next_hosted_zone_id
             (fun f -> ("next_hosted_zone_id", (String.to_json f)));
           Util.option_map v.next_d_n_s_name
             (fun f -> ("next_d_n_s_name", (String.to_json f)));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Util.option_map v.hosted_zone_id
             (fun f -> ("hosted_zone_id", (String.to_json f)));
           Util.option_map v.d_n_s_name
             (fun f -> ("d_n_s_name", (String.to_json f)));
           Some ("hosted_zones", (HostedZones.to_json v.hosted_zones))])
    let parse xml =
      Some
        {
          hosted_zones =
            (Xml.required "HostedZones"
               (Util.option_bind (Xml.member "HostedZones" xml)
                  HostedZones.parse));
          d_n_s_name =
            (Util.option_bind (Xml.member "DNSName" xml) String.parse);
          hosted_zone_id =
            (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse);
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          next_d_n_s_name =
            (Util.option_bind (Xml.member "NextDNSName" xml) String.parse);
          next_hosted_zone_id =
            (Util.option_bind (Xml.member "NextHostedZoneId" xml)
               String.parse);
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "HostedZones"
                            ([], (HostedZones.to_xml [x])))) v.hosted_zones))
                @
                [Util.option_map v.d_n_s_name
                   (fun f ->
                      Ezxmlm.make_tag "DNSName" ([], (String.to_xml f)))])
               @
               [Util.option_map v.hosted_zone_id
                  (fun f ->
                     Ezxmlm.make_tag "HostedZoneId" ([], (String.to_xml f)))])
              @
              [Some
                 (Ezxmlm.make_tag "IsTruncated"
                    ([], (Boolean.to_xml v.is_truncated)))])
             @
             [Util.option_map v.next_d_n_s_name
                (fun f ->
                   Ezxmlm.make_tag "NextDNSName" ([], (String.to_xml f)))])
            @
            [Util.option_map v.next_hosted_zone_id
               (fun f ->
                  Ezxmlm.make_tag "NextHostedZoneId" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the request.</p>"]
module DeleteReusableDelegationSetResponse =
  struct
    type t = unit[@@ocaml.doc "<p>An empty element.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p>An empty element.</p>"]
module DeleteQueryLoggingConfigResponse =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module GetTrafficPolicyInstanceResponse =
  struct
    type t =
      {
      traffic_policy_instance: TrafficPolicyInstance.t
        [@ocaml.doc
          "<p>A complex type that contains settings for the traffic policy instance.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the resource record sets that Amazon Route 53 created based on a specified traffic policy.</p>"]
    let make ~traffic_policy_instance  () = { traffic_policy_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("traffic_policy_instance",
                (TrafficPolicyInstance.to_json v.traffic_policy_instance))])
    let parse xml =
      Some
        {
          traffic_policy_instance =
            (Xml.required "TrafficPolicyInstance"
               (Util.option_bind (Xml.member "TrafficPolicyInstance" xml)
                  TrafficPolicyInstance.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "TrafficPolicyInstance"
                 ([],
                   (TrafficPolicyInstance.to_xml v.traffic_policy_instance)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the resource record sets that Amazon Route 53 created based on a specified traffic policy.</p>"]
module AssociateVPCWithHostedZoneResponse =
  struct
    type t =
      {
      change_info: ChangeInfo.t
        [@ocaml.doc
          "<p>A complex type that describes the changes made to your hosted zone.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the <code>AssociateVPCWithHostedZone</code> request.</p>"]
    let make ~change_info  () = { change_info }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("change_info", (ChangeInfo.to_json v.change_info))])
    let parse xml =
      Some
        {
          change_info =
            (Xml.required "ChangeInfo"
               (Util.option_bind (Xml.member "ChangeInfo" xml)
                  ChangeInfo.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "ChangeInfo"
                 ([], (ChangeInfo.to_xml v.change_info)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the <code>AssociateVPCWithHostedZone</code> request.</p>"]
module ListTrafficPolicyVersionsResponse =
  struct
    type t =
      {
      traffic_policies: TrafficPolicies.t
        [@ocaml.doc
          "<p>A list that contains one <code>TrafficPolicy</code> element for each traffic policy version that is associated with the specified traffic policy.</p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A flag that indicates whether there are more traffic policies to be listed. If the response was truncated, you can get the next group of traffic policies by submitting another <code>ListTrafficPolicyVersions</code> request and specifying the value of <code>NextMarker</code> in the <code>marker</code> parameter.</p>"];
      traffic_policy_version_marker: String.t
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, the value of <code>TrafficPolicyVersionMarker</code> identifies the first traffic policy that Amazon Route 53 will return if you submit another request. Call <code>ListTrafficPolicyVersions</code> again and specify the value of <code>TrafficPolicyVersionMarker</code> in the <code>TrafficPolicyVersionMarker</code> request parameter.</p> <p>This element is present only if <code>IsTruncated</code> is <code>true</code>.</p>"];
      max_items: String.t
        [@ocaml.doc
          "<p>The value that you specified for the <code>maxitems</code> parameter in the <code>ListTrafficPolicyVersions</code> request that produced the current response.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the request.</p>"]
    let make ~traffic_policies  ~is_truncated  ~traffic_policy_version_marker
       ~max_items  () =
      {
        traffic_policies;
        is_truncated;
        traffic_policy_version_marker;
        max_items
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Some
             ("traffic_policy_version_marker",
               (String.to_json v.traffic_policy_version_marker));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Some
             ("traffic_policies",
               (TrafficPolicies.to_json v.traffic_policies))])
    let parse xml =
      Some
        {
          traffic_policies =
            (Xml.required "TrafficPolicies"
               (Util.option_bind (Xml.member "TrafficPolicies" xml)
                  TrafficPolicies.parse));
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          traffic_policy_version_marker =
            (Xml.required "TrafficPolicyVersionMarker"
               (Util.option_bind
                  (Xml.member "TrafficPolicyVersionMarker" xml) String.parse));
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "TrafficPolicies"
                         ([], (TrafficPolicies.to_xml [x]))))
                 v.traffic_policies))
             @
             [Some
                (Ezxmlm.make_tag "IsTruncated"
                   ([], (Boolean.to_xml v.is_truncated)))])
            @
            [Some
               (Ezxmlm.make_tag "TrafficPolicyVersionMarker"
                  ([], (String.to_xml v.traffic_policy_version_marker)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the request.</p>"]
module GetGeoLocationResponse =
  struct
    type t =
      {
      geo_location_details: GeoLocationDetails.t
        [@ocaml.doc
          "<p>A complex type that contains the codes and full continent, country, and subdivision names for the specified geolocation code.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the specified geolocation code.</p>"]
    let make ~geo_location_details  () = { geo_location_details }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("geo_location_details",
                (GeoLocationDetails.to_json v.geo_location_details))])
    let parse xml =
      Some
        {
          geo_location_details =
            (Xml.required "GeoLocationDetails"
               (Util.option_bind (Xml.member "GeoLocationDetails" xml)
                  GeoLocationDetails.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "GeoLocationDetails"
                 ([], (GeoLocationDetails.to_xml v.geo_location_details)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the specified geolocation code.</p>"]
module GetHealthCheckLastFailureReasonResponse =
  struct
    type t =
      {
      health_check_observations: HealthCheckObservations.t
        [@ocaml.doc
          "<p>A list that contains one <code>Observation</code> element for each Amazon Route 53 health checker that is reporting a last failure reason. </p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to a <code>GetHealthCheckLastFailureReason</code> request.</p>"]
    let make ~health_check_observations  () = { health_check_observations }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("health_check_observations",
                (HealthCheckObservations.to_json v.health_check_observations))])
    let parse xml =
      Some
        {
          health_check_observations =
            (Xml.required "HealthCheckObservations"
               (Util.option_bind (Xml.member "HealthCheckObservations" xml)
                  HealthCheckObservations.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "HealthCheckObservations"
                      ([], (HealthCheckObservations.to_xml [x]))))
              v.health_check_observations))
  end[@@ocaml.doc
       "<p>A complex type that contains the response to a <code>GetHealthCheckLastFailureReason</code> request.</p>"]
module DeleteTrafficPolicyInstanceResponse =
  struct
    type t = unit[@@ocaml.doc "<p>An empty element.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p>An empty element.</p>"]
module CreateHostedZoneResponse =
  struct
    type t =
      {
      hosted_zone: HostedZone.t
        [@ocaml.doc
          "<p>A complex type that contains general information about the hosted zone.</p>"];
      change_info: ChangeInfo.t
        [@ocaml.doc
          "<p>A complex type that contains information about the <code>CreateHostedZone</code> request.</p>"];
      delegation_set: DelegationSet.t
        [@ocaml.doc
          "<p>A complex type that describes the name servers for this hosted zone.</p>"];
      v_p_c: VPC.t option
        [@ocaml.doc
          "<p>A complex type that contains information about an Amazon VPC that you associated with this hosted zone.</p>"];
      location: String.t
        [@ocaml.doc
          "<p>The unique URL representing the new hosted zone.</p>"]}
    [@@ocaml.doc
      "<p>A complex type containing the response information for the hosted zone.</p>"]
    let make ~hosted_zone  ~change_info  ~delegation_set  ?v_p_c  ~location 
      () = { hosted_zone; change_info; delegation_set; v_p_c; location }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Some (Headers.Pair ("Location", (String.to_headers v.location)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("location", (String.to_json v.location));
           Util.option_map v.v_p_c (fun f -> ("v_p_c", (VPC.to_json f)));
           Some ("delegation_set", (DelegationSet.to_json v.delegation_set));
           Some ("change_info", (ChangeInfo.to_json v.change_info));
           Some ("hosted_zone", (HostedZone.to_json v.hosted_zone))])
    let parse xml =
      Some
        {
          hosted_zone =
            (Xml.required "HostedZone"
               (Util.option_bind (Xml.member "HostedZone" xml)
                  HostedZone.parse));
          change_info =
            (Xml.required "ChangeInfo"
               (Util.option_bind (Xml.member "ChangeInfo" xml)
                  ChangeInfo.parse));
          delegation_set =
            (Xml.required "DelegationSet"
               (Util.option_bind (Xml.member "DelegationSet" xml)
                  DelegationSet.parse));
          v_p_c = (Util.option_bind (Xml.member "VPC" xml) VPC.parse);
          location =
            (Xml.required "Location"
               (Util.option_bind (Xml.member "Location" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "HostedZone"
                     ([], (HostedZone.to_xml v.hosted_zone)))])
              @
              [Some
                 (Ezxmlm.make_tag "ChangeInfo"
                    ([], (ChangeInfo.to_xml v.change_info)))])
             @
             [Some
                (Ezxmlm.make_tag "DelegationSet"
                   ([], (DelegationSet.to_xml v.delegation_set)))])
            @
            [Util.option_map v.v_p_c
               (fun f -> Ezxmlm.make_tag "VPC" ([], (VPC.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "Location" ([], (String.to_xml v.location)))])
  end[@@ocaml.doc
       "<p>A complex type containing the response information for the hosted zone.</p>"]
module GetQueryLoggingConfigResponse =
  struct
    type t =
      {
      query_logging_config: QueryLoggingConfig.t
        [@ocaml.doc
          "<p>A complex type that contains information about the query logging configuration that you specified in a <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetQueryLoggingConfig.html\">GetQueryLoggingConfig</a> request.</p>"]}
    let make ~query_logging_config  () = { query_logging_config }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("query_logging_config",
                (QueryLoggingConfig.to_json v.query_logging_config))])
    let parse xml =
      Some
        {
          query_logging_config =
            (Xml.required "QueryLoggingConfig"
               (Util.option_bind (Xml.member "QueryLoggingConfig" xml)
                  QueryLoggingConfig.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "QueryLoggingConfig"
                 ([], (QueryLoggingConfig.to_xml v.query_logging_config)))])
  end
module GetHealthCheckStatusResponse =
  struct
    type t =
      {
      health_check_observations: HealthCheckObservations.t
        [@ocaml.doc
          "<p>A list that contains one <code>HealthCheckObservation</code> element for each Amazon Route 53 health checker that is reporting a status about the health check endpoint.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to a <code>GetHealthCheck</code> request.</p>"]
    let make ~health_check_observations  () = { health_check_observations }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("health_check_observations",
                (HealthCheckObservations.to_json v.health_check_observations))])
    let parse xml =
      Some
        {
          health_check_observations =
            (Xml.required "HealthCheckObservations"
               (Util.option_bind (Xml.member "HealthCheckObservations" xml)
                  HealthCheckObservations.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "HealthCheckObservations"
                      ([], (HealthCheckObservations.to_xml [x]))))
              v.health_check_observations))
  end[@@ocaml.doc
       "<p>A complex type that contains the response to a <code>GetHealthCheck</code> request.</p>"]
module GetCheckerIpRangesResponse =
  struct
    type t =
      {
      checker_ip_ranges: CheckerIpRanges.t
        [@ocaml.doc
          "<p>A complex type that contains sorted list of IP ranges in CIDR format for Amazon Route 53 health checkers.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the <code>CheckerIpRanges</code> element.</p>"]
    let make ~checker_ip_ranges  () = { checker_ip_ranges }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("checker_ip_ranges",
                (CheckerIpRanges.to_json v.checker_ip_ranges))])
    let parse xml =
      Some
        {
          checker_ip_ranges =
            (Xml.required "CheckerIpRanges"
               (Util.option_bind (Xml.member "CheckerIpRanges" xml)
                  CheckerIpRanges.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CheckerIpRanges"
                      ([], (CheckerIpRanges.to_xml [x]))))
              v.checker_ip_ranges))
  end[@@ocaml.doc
       "<p>A complex type that contains the <code>CheckerIpRanges</code> element.</p>"]
module ListTrafficPolicyInstancesResponse =
  struct
    type t =
      {
      traffic_policy_instances: TrafficPolicyInstances.t
        [@ocaml.doc
          "<p>A list that contains one <code>TrafficPolicyInstance</code> element for each traffic policy instance that matches the elements in the request.</p>"];
      hosted_zone_id_marker: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, <code>HostedZoneIdMarker</code> is the ID of the hosted zone of the first traffic policy instance that Route 53 will return if you submit another <code>ListTrafficPolicyInstances</code> request. </p>"];
      traffic_policy_instance_name_marker: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, <code>TrafficPolicyInstanceNameMarker</code> is the name of the first traffic policy instance that Route 53 will return if you submit another <code>ListTrafficPolicyInstances</code> request. </p>"];
      traffic_policy_instance_type_marker: RRType.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, <code>TrafficPolicyInstanceTypeMarker</code> is the DNS type of the resource record sets that are associated with the first traffic policy instance that Amazon Route 53 will return if you submit another <code>ListTrafficPolicyInstances</code> request. </p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A flag that indicates whether there are more traffic policy instances to be listed. If the response was truncated, you can get more traffic policy instances by calling <code>ListTrafficPolicyInstances</code> again and specifying the values of the <code>HostedZoneIdMarker</code>, <code>TrafficPolicyInstanceNameMarker</code>, and <code>TrafficPolicyInstanceTypeMarker</code> in the corresponding request parameters.</p>"];
      max_items: String.t
        [@ocaml.doc
          "<p>The value that you specified for the <code>MaxItems</code> parameter in the call to <code>ListTrafficPolicyInstances</code> that produced the current response.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the request.</p>"]
    let make ~traffic_policy_instances  ?hosted_zone_id_marker 
      ?traffic_policy_instance_name_marker 
      ?traffic_policy_instance_type_marker  ~is_truncated  ~max_items  () =
      {
        traffic_policy_instances;
        hosted_zone_id_marker;
        traffic_policy_instance_name_marker;
        traffic_policy_instance_type_marker;
        is_truncated;
        max_items
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Util.option_map v.traffic_policy_instance_type_marker
             (fun f ->
                ("traffic_policy_instance_type_marker", (RRType.to_json f)));
           Util.option_map v.traffic_policy_instance_name_marker
             (fun f ->
                ("traffic_policy_instance_name_marker", (String.to_json f)));
           Util.option_map v.hosted_zone_id_marker
             (fun f -> ("hosted_zone_id_marker", (String.to_json f)));
           Some
             ("traffic_policy_instances",
               (TrafficPolicyInstances.to_json v.traffic_policy_instances))])
    let parse xml =
      Some
        {
          traffic_policy_instances =
            (Xml.required "TrafficPolicyInstances"
               (Util.option_bind (Xml.member "TrafficPolicyInstances" xml)
                  TrafficPolicyInstances.parse));
          hosted_zone_id_marker =
            (Util.option_bind (Xml.member "HostedZoneIdMarker" xml)
               String.parse);
          traffic_policy_instance_name_marker =
            (Util.option_bind
               (Xml.member "TrafficPolicyInstanceNameMarker" xml)
               String.parse);
          traffic_policy_instance_type_marker =
            (Util.option_bind
               (Xml.member "TrafficPolicyInstanceTypeMarker" xml)
               RRType.parse);
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "TrafficPolicyInstances"
                           ([], (TrafficPolicyInstances.to_xml [x]))))
                   v.traffic_policy_instances))
               @
               [Util.option_map v.hosted_zone_id_marker
                  (fun f ->
                     Ezxmlm.make_tag "HostedZoneIdMarker"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.traffic_policy_instance_name_marker
                 (fun f ->
                    Ezxmlm.make_tag "TrafficPolicyInstanceNameMarker"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.traffic_policy_instance_type_marker
                (fun f ->
                   Ezxmlm.make_tag "TrafficPolicyInstanceTypeMarker"
                     ([], (RRType.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "IsTruncated"
                  ([], (Boolean.to_xml v.is_truncated)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the request.</p>"]
module GetHealthCheckResponse =
  struct
    type t =
      {
      health_check: HealthCheck.t
        [@ocaml.doc
          "<p>A complex type that contains information about one health check that is associated with the current AWS account.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to a <code>GetHealthCheck</code> request.</p>"]
    let make ~health_check  () = { health_check }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("health_check", (HealthCheck.to_json v.health_check))])
    let parse xml =
      Some
        {
          health_check =
            (Xml.required "HealthCheck"
               (Util.option_bind (Xml.member "HealthCheck" xml)
                  HealthCheck.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "HealthCheck"
                 ([], (HealthCheck.to_xml v.health_check)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response to a <code>GetHealthCheck</code> request.</p>"]
module GetCheckerIpRangesRequest =
  struct
    type t = unit[@@ocaml.doc "<p>Empty request.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p>Empty request.</p>"]
module GetTrafficPolicyResponse =
  struct
    type t =
      {
      traffic_policy: TrafficPolicy.t
        [@ocaml.doc
          "<p>A complex type that contains settings for the specified traffic policy.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the request.</p>"]
    let make ~traffic_policy  () = { traffic_policy }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("traffic_policy", (TrafficPolicy.to_json v.traffic_policy))])
    let parse xml =
      Some
        {
          traffic_policy =
            (Xml.required "TrafficPolicy"
               (Util.option_bind (Xml.member "TrafficPolicy" xml)
                  TrafficPolicy.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "TrafficPolicy"
                 ([], (TrafficPolicy.to_xml v.traffic_policy)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the request.</p>"]
module GetReusableDelegationSetResponse =
  struct
    type t =
      {
      delegation_set: DelegationSet.t
        [@ocaml.doc
          "<p>A complex type that contains information about the reusable delegation set.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to the <code>GetReusableDelegationSet</code> request.</p>"]
    let make ~delegation_set  () = { delegation_set }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("delegation_set", (DelegationSet.to_json v.delegation_set))])
    let parse xml =
      Some
        {
          delegation_set =
            (Xml.required "DelegationSet"
               (Util.option_bind (Xml.member "DelegationSet" xml)
                  DelegationSet.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "DelegationSet"
                 ([], (DelegationSet.to_xml v.delegation_set)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response to the <code>GetReusableDelegationSet</code> request.</p>"]
module ChangeResourceRecordSetsResponse =
  struct
    type t =
      {
      change_info: ChangeInfo.t
        [@ocaml.doc
          "<p>A complex type that contains information about changes made to your hosted zone.</p> <p>This element contains an ID that you use when performing a <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetChange.html\">GetChange</a> action to get detailed information about the change.</p>"]}
    [@@ocaml.doc
      "<p>A complex type containing the response for the request.</p>"]
    let make ~change_info  () = { change_info }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("change_info", (ChangeInfo.to_json v.change_info))])
    let parse xml =
      Some
        {
          change_info =
            (Xml.required "ChangeInfo"
               (Util.option_bind (Xml.member "ChangeInfo" xml)
                  ChangeInfo.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "ChangeInfo"
                 ([], (ChangeInfo.to_xml v.change_info)))])
  end[@@ocaml.doc
       "<p>A complex type containing the response for the request.</p>"]
module ChangeTagsForResourceResponse =
  struct
    type t = unit[@@ocaml.doc "<p>Empty response for the request.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p>Empty response for the request.</p>"]
module GetHostedZoneCountRequest =
  struct
    type t = unit[@@ocaml.doc
                   "<p>A request to retrieve a count of all the hosted zones that are associated with the current AWS account.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc
       "<p>A request to retrieve a count of all the hosted zones that are associated with the current AWS account.</p>"]
module GetHealthCheckCountResponse =
  struct
    type t =
      {
      health_check_count: Long.t
        [@ocaml.doc
          "<p>The number of health checks associated with the current AWS account.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to a <code>GetHealthCheckCount</code> request.</p>"]
    let make ~health_check_count  () = { health_check_count }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("health_check_count", (Long.to_json v.health_check_count))])
    let parse xml =
      Some
        {
          health_check_count =
            (Xml.required "HealthCheckCount"
               (Util.option_bind (Xml.member "HealthCheckCount" xml)
                  Long.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "HealthCheckCount"
                 ([], (Long.to_xml v.health_check_count)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response to a <code>GetHealthCheckCount</code> request.</p>"]
module ListVPCAssociationAuthorizationsResponse =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that you can associate the listed VPCs with.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>When the response includes a <code>NextToken</code> element, there are more VPCs that can be associated with the specified hosted zone. To get the next page of VPCs, submit another <code>ListVPCAssociationAuthorizations</code> request, and include the value of the <code>NextToken</code> element from the response in the <code>nexttoken</code> request parameter.</p>"];
      v_p_cs: VPCs.t
        [@ocaml.doc
          "<p>The list of VPCs that are authorized to be associated with the specified hosted zone.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the request.</p>"]
    let make ~hosted_zone_id  ?next_token  ~v_p_cs  () =
      { hosted_zone_id; next_token; v_p_cs }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("v_p_cs", (VPCs.to_json v.v_p_cs));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "HostedZoneId"
               (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          v_p_cs =
            (Xml.required "VPCs"
               (Util.option_bind (Xml.member "VPCs" xml) VPCs.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "HostedZoneId"
                   ([], (String.to_xml v.hosted_zone_id)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x -> Some (Ezxmlm.make_tag "VPCs" ([], (VPCs.to_xml [x]))))
              v.v_p_cs))
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the request.</p>"]
module CreateVPCAssociationAuthorizationResponse =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that you authorized associating a VPC with.</p>"];
      v_p_c: VPC.t
        [@ocaml.doc
          "<p>The VPC that you authorized associating with a hosted zone.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information from a <code>CreateVPCAssociationAuthorization</code> request.</p>"]
    let make ~hosted_zone_id  ~v_p_c  () = { hosted_zone_id; v_p_c }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("v_p_c", (VPC.to_json v.v_p_c));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "HostedZoneId"
               (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse));
          v_p_c =
            (Xml.required "VPC"
               (Util.option_bind (Xml.member "VPC" xml) VPC.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "HostedZoneId"
                  ([], (String.to_xml v.hosted_zone_id)))])
           @ [Some (Ezxmlm.make_tag "VPC" ([], (VPC.to_xml v.v_p_c)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information from a <code>CreateVPCAssociationAuthorization</code> request.</p>"]
module ListHostedZonesResponse =
  struct
    type t =
      {
      hosted_zones: HostedZones.t
        [@ocaml.doc
          "<p>A complex type that contains general information about the hosted zone.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>For the second and subsequent calls to <code>ListHostedZones</code>, <code>Marker</code> is the value that you specified for the <code>marker</code> parameter in the request that produced the current response.</p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A flag indicating whether there are more hosted zones to be listed. If the response was truncated, you can get more hosted zones by submitting another <code>ListHostedZones</code> request and specifying the value of <code>NextMarker</code> in the <code>marker</code> parameter.</p>"];
      next_marker: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, the value of <code>NextMarker</code> identifies the first hosted zone in the next group of hosted zones. Submit another <code>ListHostedZones</code> request, and specify the value of <code>NextMarker</code> from the response in the <code>marker</code> parameter.</p> <p>This element is present only if <code>IsTruncated</code> is <code>true</code>.</p>"];
      max_items: String.t
        [@ocaml.doc
          "<p>The value that you specified for the <code>maxitems</code> parameter in the call to <code>ListHostedZones</code> that produced the current response.</p>"]}
    let make ~hosted_zones  ?marker  ~is_truncated  ?next_marker  ~max_items 
      () = { hosted_zones; marker; is_truncated; next_marker; max_items }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Util.option_map v.next_marker
             (fun f -> ("next_marker", (String.to_json f)));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Some ("hosted_zones", (HostedZones.to_json v.hosted_zones))])
    let parse xml =
      Some
        {
          hosted_zones =
            (Xml.required "HostedZones"
               (Util.option_bind (Xml.member "HostedZones" xml)
                  HostedZones.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          next_marker =
            (Util.option_bind (Xml.member "NextMarker" xml) String.parse);
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "HostedZones"
                          ([], (HostedZones.to_xml [x])))) v.hosted_zones))
              @
              [Util.option_map v.marker
                 (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "IsTruncated"
                   ([], (Boolean.to_xml v.is_truncated)))])
            @
            [Util.option_map v.next_marker
               (fun f -> Ezxmlm.make_tag "NextMarker" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end
module ErrorMessages =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "Message" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ListTagsForResourceResponse =
  struct
    type t =
      {
      resource_tag_set: ResourceTagSet.t
        [@ocaml.doc
          "<p>A <code>ResourceTagSet</code> containing tags associated with the specified resource.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the health checks or hosted zones for which you want to list tags.</p>"]
    let make ~resource_tag_set  () = { resource_tag_set }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("resource_tag_set",
                (ResourceTagSet.to_json v.resource_tag_set))])
    let parse xml =
      Some
        {
          resource_tag_set =
            (Xml.required "ResourceTagSet"
               (Util.option_bind (Xml.member "ResourceTagSet" xml)
                  ResourceTagSet.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "ResourceTagSet"
                 ([], (ResourceTagSet.to_xml v.resource_tag_set)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the health checks or hosted zones for which you want to list tags.</p>"]
module CreateHealthCheckResponse =
  struct
    type t =
      {
      health_check: HealthCheck.t
        [@ocaml.doc
          "<p>A complex type that contains identifying information about the health check.</p>"];
      location: String.t
        [@ocaml.doc
          "<p>The unique URL representing the new health check.</p>"]}
    [@@ocaml.doc
      "<p>A complex type containing the response information for the new health check.</p>"]
    let make ~health_check  ~location  () = { health_check; location }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Some (Headers.Pair ("Location", (String.to_headers v.location)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("location", (String.to_json v.location));
           Some ("health_check", (HealthCheck.to_json v.health_check))])
    let parse xml =
      Some
        {
          health_check =
            (Xml.required "HealthCheck"
               (Util.option_bind (Xml.member "HealthCheck" xml)
                  HealthCheck.parse));
          location =
            (Xml.required "Location"
               (Util.option_bind (Xml.member "Location" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "HealthCheck"
                  ([], (HealthCheck.to_xml v.health_check)))])
           @
           [Some
              (Ezxmlm.make_tag "Location" ([], (String.to_xml v.location)))])
  end[@@ocaml.doc
       "<p>A complex type containing the response information for the new health check.</p>"]
module GetChangeResponse =
  struct
    type t =
      {
      change_info: ChangeInfo.t
        [@ocaml.doc
          "<p>A complex type that contains information about the specified change batch.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the <code>ChangeInfo</code> element.</p>"]
    let make ~change_info  () = { change_info }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("change_info", (ChangeInfo.to_json v.change_info))])
    let parse xml =
      Some
        {
          change_info =
            (Xml.required "ChangeInfo"
               (Util.option_bind (Xml.member "ChangeInfo" xml)
                  ChangeInfo.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "ChangeInfo"
                 ([], (ChangeInfo.to_xml v.change_info)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the <code>ChangeInfo</code> element.</p>"]
module ListGeoLocationsResponse =
  struct
    type t =
      {
      geo_location_details_list: GeoLocationDetailsList.t
        [@ocaml.doc
          "<p>A complex type that contains one <code>GeoLocationDetails</code> element for each location that Amazon Route 53 supports for geolocation.</p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A value that indicates whether more locations remain to be listed after the last location in this response. If so, the value of <code>IsTruncated</code> is <code>true</code>. To get more values, submit another request and include the values of <code>NextContinentCode</code>, <code>NextCountryCode</code>, and <code>NextSubdivisionCode</code> in the <code>startcontinentcode</code>, <code>startcountrycode</code>, and <code>startsubdivisioncode</code>, as applicable.</p>"];
      next_continent_code: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, you can make a follow-up request to display more locations. Enter the value of <code>NextContinentCode</code> in the <code>startcontinentcode</code> parameter in another <code>ListGeoLocations</code> request.</p>"];
      next_country_code: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, you can make a follow-up request to display more locations. Enter the value of <code>NextCountryCode</code> in the <code>startcountrycode</code> parameter in another <code>ListGeoLocations</code> request.</p>"];
      next_subdivision_code: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, you can make a follow-up request to display more locations. Enter the value of <code>NextSubdivisionCode</code> in the <code>startsubdivisioncode</code> parameter in another <code>ListGeoLocations</code> request.</p>"];
      max_items: String.t
        [@ocaml.doc
          "<p>The value that you specified for <code>MaxItems</code> in the request.</p>"]}
    [@@ocaml.doc
      "<p>A complex type containing the response information for the request.</p>"]
    let make ~geo_location_details_list  ~is_truncated  ?next_continent_code 
      ?next_country_code  ?next_subdivision_code  ~max_items  () =
      {
        geo_location_details_list;
        is_truncated;
        next_continent_code;
        next_country_code;
        next_subdivision_code;
        max_items
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Util.option_map v.next_subdivision_code
             (fun f -> ("next_subdivision_code", (String.to_json f)));
           Util.option_map v.next_country_code
             (fun f -> ("next_country_code", (String.to_json f)));
           Util.option_map v.next_continent_code
             (fun f -> ("next_continent_code", (String.to_json f)));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Some
             ("geo_location_details_list",
               (GeoLocationDetailsList.to_json v.geo_location_details_list))])
    let parse xml =
      Some
        {
          geo_location_details_list =
            (Xml.required "GeoLocationDetailsList"
               (Util.option_bind (Xml.member "GeoLocationDetailsList" xml)
                  GeoLocationDetailsList.parse));
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          next_continent_code =
            (Util.option_bind (Xml.member "NextContinentCode" xml)
               String.parse);
          next_country_code =
            (Util.option_bind (Xml.member "NextCountryCode" xml) String.parse);
          next_subdivision_code =
            (Util.option_bind (Xml.member "NextSubdivisionCode" xml)
               String.parse);
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "GeoLocationDetailsList"
                           ([], (GeoLocationDetailsList.to_xml [x]))))
                   v.geo_location_details_list))
               @
               [Some
                  (Ezxmlm.make_tag "IsTruncated"
                     ([], (Boolean.to_xml v.is_truncated)))])
              @
              [Util.option_map v.next_continent_code
                 (fun f ->
                    Ezxmlm.make_tag "NextContinentCode"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.next_country_code
                (fun f ->
                   Ezxmlm.make_tag "NextCountryCode" ([], (String.to_xml f)))])
            @
            [Util.option_map v.next_subdivision_code
               (fun f ->
                  Ezxmlm.make_tag "NextSubdivisionCode"
                    ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end[@@ocaml.doc
       "<p>A complex type containing the response information for the request.</p>"]
module GetHostedZoneLimitResponse =
  struct
    type t =
      {
      limit: HostedZoneLimit.t
        [@ocaml.doc
          "<p>The current setting for the specified limit. For example, if you specified <code>MAX_RRSETS_BY_ZONE</code> for the value of <code>Type</code> in the request, the value of <code>Limit</code> is the maximum number of records that you can create in the specified hosted zone.</p>"];
      count: Long.t
        [@ocaml.doc
          "<p>The current number of entities that you have created of the specified type. For example, if you specified <code>MAX_RRSETS_BY_ZONE</code> for the value of <code>Type</code> in the request, the value of <code>Count</code> is the current number of records that you have created in the specified hosted zone.</p>"]}
    [@@ocaml.doc "<p>A complex type that contains the requested limit. </p>"]
    let make ~limit  ~count  () = { limit; count }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("count", (Long.to_json v.count));
           Some ("limit", (HostedZoneLimit.to_json v.limit))])
    let parse xml =
      Some
        {
          limit =
            (Xml.required "Limit"
               (Util.option_bind (Xml.member "Limit" xml)
                  HostedZoneLimit.parse));
          count =
            (Xml.required "Count"
               (Util.option_bind (Xml.member "Count" xml) Long.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Limit"
                  ([], (HostedZoneLimit.to_xml v.limit)))])
           @ [Some (Ezxmlm.make_tag "Count" ([], (Long.to_xml v.count)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the requested limit. </p>"]
module ListHealthChecksResponse =
  struct
    type t =
      {
      health_checks: HealthChecks.t
        [@ocaml.doc
          "<p>A complex type that contains one <code>HealthCheck</code> element for each health check that is associated with the current AWS account.</p>"];
      marker: String.t
        [@ocaml.doc
          "<p>For the second and subsequent calls to <code>ListHealthChecks</code>, <code>Marker</code> is the value that you specified for the <code>marker</code> parameter in the previous request.</p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A flag that indicates whether there are more health checks to be listed. If the response was truncated, you can get the next group of health checks by submitting another <code>ListHealthChecks</code> request and specifying the value of <code>NextMarker</code> in the <code>marker</code> parameter.</p>"];
      next_marker: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, the value of <code>NextMarker</code> identifies the first health check that Amazon Route 53 returns if you submit another <code>ListHealthChecks</code> request and specify the value of <code>NextMarker</code> in the <code>marker</code> parameter.</p>"];
      max_items: String.t
        [@ocaml.doc
          "<p>The value that you specified for the <code>maxitems</code> parameter in the call to <code>ListHealthChecks</code> that produced the current response.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to a <code>ListHealthChecks</code> request.</p>"]
    let make ~health_checks  ~marker  ~is_truncated  ?next_marker  ~max_items
       () = { health_checks; marker; is_truncated; next_marker; max_items }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Util.option_map v.next_marker
             (fun f -> ("next_marker", (String.to_json f)));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Some ("marker", (String.to_json v.marker));
           Some ("health_checks", (HealthChecks.to_json v.health_checks))])
    let parse xml =
      Some
        {
          health_checks =
            (Xml.required "HealthChecks"
               (Util.option_bind (Xml.member "HealthChecks" xml)
                  HealthChecks.parse));
          marker =
            (Xml.required "Marker"
               (Util.option_bind (Xml.member "Marker" xml) String.parse));
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          next_marker =
            (Util.option_bind (Xml.member "NextMarker" xml) String.parse);
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "HealthChecks"
                          ([], (HealthChecks.to_xml [x])))) v.health_checks))
              @
              [Some (Ezxmlm.make_tag "Marker" ([], (String.to_xml v.marker)))])
             @
             [Some
                (Ezxmlm.make_tag "IsTruncated"
                   ([], (Boolean.to_xml v.is_truncated)))])
            @
            [Util.option_map v.next_marker
               (fun f -> Ezxmlm.make_tag "NextMarker" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response to a <code>ListHealthChecks</code> request.</p>"]
module ListQueryLoggingConfigsResponse =
  struct
    type t =
      {
      query_logging_configs: QueryLoggingConfigs.t
        [@ocaml.doc
          "<p>An array that contains one <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_QueryLoggingConfig.html\">QueryLoggingConfig</a> element for each configuration for DNS query logging that is associated with the current AWS account.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If a response includes the last of the query logging configurations that are associated with the current AWS account, <code>NextToken</code> doesn't appear in the response.</p> <p>If a response doesn't include the last of the configurations, you can get more configurations by submitting another <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_ListQueryLoggingConfigs.html\">ListQueryLoggingConfigs</a> request. Get the value of <code>NextToken</code> that Amazon Route 53 returned in the previous response and include it in <code>NextToken</code> in the next request.</p>"]}
    let make ~query_logging_configs  ?next_token  () =
      { query_logging_configs; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("query_logging_configs",
               (QueryLoggingConfigs.to_json v.query_logging_configs))])
    let parse xml =
      Some
        {
          query_logging_configs =
            (Xml.required "QueryLoggingConfigs"
               (Util.option_bind (Xml.member "QueryLoggingConfigs" xml)
                  QueryLoggingConfigs.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "QueryLoggingConfigs"
                       ([], (QueryLoggingConfigs.to_xml [x]))))
               v.query_logging_configs))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module CreateTrafficPolicyInstanceResponse =
  struct
    type t =
      {
      traffic_policy_instance: TrafficPolicyInstance.t
        [@ocaml.doc
          "<p>A complex type that contains settings for the new traffic policy instance.</p>"];
      location: String.t
        [@ocaml.doc
          "<p>A unique URL that represents a new traffic policy instance.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the <code>CreateTrafficPolicyInstance</code> request.</p>"]
    let make ~traffic_policy_instance  ~location  () =
      { traffic_policy_instance; location }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Some (Headers.Pair ("Location", (String.to_headers v.location)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("location", (String.to_json v.location));
           Some
             ("traffic_policy_instance",
               (TrafficPolicyInstance.to_json v.traffic_policy_instance))])
    let parse xml =
      Some
        {
          traffic_policy_instance =
            (Xml.required "TrafficPolicyInstance"
               (Util.option_bind (Xml.member "TrafficPolicyInstance" xml)
                  TrafficPolicyInstance.parse));
          location =
            (Xml.required "Location"
               (Util.option_bind (Xml.member "Location" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "TrafficPolicyInstance"
                  ([],
                    (TrafficPolicyInstance.to_xml v.traffic_policy_instance)))])
           @
           [Some
              (Ezxmlm.make_tag "Location" ([], (String.to_xml v.location)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the <code>CreateTrafficPolicyInstance</code> request.</p>"]
module GetTrafficPolicyInstanceCountResponse =
  struct
    type t =
      {
      traffic_policy_instance_count: Integer.t
        [@ocaml.doc
          "<p>The number of traffic policy instances that are associated with the current AWS account.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the resource record sets that Amazon Route 53 created based on a specified traffic policy.</p>"]
    let make ~traffic_policy_instance_count  () =
      { traffic_policy_instance_count }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("traffic_policy_instance_count",
                (Integer.to_json v.traffic_policy_instance_count))])
    let parse xml =
      Some
        {
          traffic_policy_instance_count =
            (Xml.required "TrafficPolicyInstanceCount"
               (Util.option_bind
                  (Xml.member "TrafficPolicyInstanceCount" xml) Integer.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "TrafficPolicyInstanceCount"
                 ([], (Integer.to_xml v.traffic_policy_instance_count)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the resource record sets that Amazon Route 53 created based on a specified traffic policy.</p>"]
module UpdateHealthCheckResponse =
  struct
    type t =
      {
      health_check: HealthCheck.t
        [@ocaml.doc
          "<p>A complex type that contains the response to an <code>UpdateHealthCheck</code> request.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to the <code>UpdateHealthCheck</code> request.</p>"]
    let make ~health_check  () = { health_check }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("health_check", (HealthCheck.to_json v.health_check))])
    let parse xml =
      Some
        {
          health_check =
            (Xml.required "HealthCheck"
               (Util.option_bind (Xml.member "HealthCheck" xml)
                  HealthCheck.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "HealthCheck"
                 ([], (HealthCheck.to_xml v.health_check)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response to the <code>UpdateHealthCheck</code> request.</p>"]
module CreateQueryLoggingConfigResponse =
  struct
    type t =
      {
      query_logging_config: QueryLoggingConfig.t
        [@ocaml.doc
          "<p>A complex type that contains the ID for a query logging configuration, the ID of the hosted zone that you want to log queries for, and the ARN for the log group that you want Amazon Route 53 to send query logs to.</p>"];
      location: String.t
        [@ocaml.doc
          "<p>The unique URL representing the new query logging configuration.</p>"]}
    let make ~query_logging_config  ~location  () =
      { query_logging_config; location }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Some (Headers.Pair ("Location", (String.to_headers v.location)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("location", (String.to_json v.location));
           Some
             ("query_logging_config",
               (QueryLoggingConfig.to_json v.query_logging_config))])
    let parse xml =
      Some
        {
          query_logging_config =
            (Xml.required "QueryLoggingConfig"
               (Util.option_bind (Xml.member "QueryLoggingConfig" xml)
                  QueryLoggingConfig.parse));
          location =
            (Xml.required "Location"
               (Util.option_bind (Xml.member "Location" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "QueryLoggingConfig"
                  ([], (QueryLoggingConfig.to_xml v.query_logging_config)))])
           @
           [Some
              (Ezxmlm.make_tag "Location" ([], (String.to_xml v.location)))])
  end
module ListTagsForResourcesResponse =
  struct
    type t =
      {
      resource_tag_sets: ResourceTagSetList.t
        [@ocaml.doc
          "<p>A list of <code>ResourceTagSet</code>s containing tags associated with the specified resources.</p>"]}
    [@@ocaml.doc
      "<p>A complex type containing tags for the specified resources.</p>"]
    let make ~resource_tag_sets  () = { resource_tag_sets }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("resource_tag_sets",
                (ResourceTagSetList.to_json v.resource_tag_sets))])
    let parse xml =
      Some
        {
          resource_tag_sets =
            (Xml.required "ResourceTagSets"
               (Util.option_bind (Xml.member "ResourceTagSets" xml)
                  ResourceTagSetList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ResourceTagSets"
                      ([], (ResourceTagSetList.to_xml [x]))))
              v.resource_tag_sets))
  end[@@ocaml.doc
       "<p>A complex type containing tags for the specified resources.</p>"]
module GetHostedZoneCountResponse =
  struct
    type t =
      {
      hosted_zone_count: Long.t
        [@ocaml.doc
          "<p>The total number of public and private hosted zones that are associated with the current AWS account.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to a <code>GetHostedZoneCount</code> request.</p>"]
    let make ~hosted_zone_count  () = { hosted_zone_count }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("hosted_zone_count", (Long.to_json v.hosted_zone_count))])
    let parse xml =
      Some
        {
          hosted_zone_count =
            (Xml.required "HostedZoneCount"
               (Util.option_bind (Xml.member "HostedZoneCount" xml)
                  Long.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "HostedZoneCount"
                 ([], (Long.to_xml v.hosted_zone_count)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response to a <code>GetHostedZoneCount</code> request.</p>"]
module GetTrafficPolicyInstanceCountRequest =
  struct
    type t = unit[@@ocaml.doc
                   "<p>Request to get the number of traffic policy instances that are associated with the current AWS account.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc
       "<p>Request to get the number of traffic policy instances that are associated with the current AWS account.</p>"]
module CreateReusableDelegationSetResponse =
  struct
    type t =
      {
      delegation_set: DelegationSet.t
        [@ocaml.doc
          "<p>A complex type that contains name server information.</p>"];
      location: String.t
        [@ocaml.doc
          "<p>The unique URL representing the new reusable delegation set.</p>"]}
    let make ~delegation_set  ~location  () = { delegation_set; location }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Some (Headers.Pair ("Location", (String.to_headers v.location)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("location", (String.to_json v.location));
           Some ("delegation_set", (DelegationSet.to_json v.delegation_set))])
    let parse xml =
      Some
        {
          delegation_set =
            (Xml.required "DelegationSet"
               (Util.option_bind (Xml.member "DelegationSet" xml)
                  DelegationSet.parse));
          location =
            (Xml.required "Location"
               (Util.option_bind (Xml.member "Location" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "DelegationSet"
                  ([], (DelegationSet.to_xml v.delegation_set)))])
           @
           [Some
              (Ezxmlm.make_tag "Location" ([], (String.to_xml v.location)))])
  end
module GetAccountLimitResponse =
  struct
    type t =
      {
      limit: AccountLimit.t
        [@ocaml.doc
          "<p>The current setting for the specified limit. For example, if you specified <code>MAX_HEALTH_CHECKS_BY_OWNER</code> for the value of <code>Type</code> in the request, the value of <code>Limit</code> is the maximum number of health checks that you can create using the current account.</p>"];
      count: Long.t
        [@ocaml.doc
          "<p>The current number of entities that you have created of the specified type. For example, if you specified <code>MAX_HEALTH_CHECKS_BY_OWNER</code> for the value of <code>Type</code> in the request, the value of <code>Count</code> is the current number of health checks that you have created using the current account.</p>"]}
    [@@ocaml.doc "<p>A complex type that contains the requested limit. </p>"]
    let make ~limit  ~count  () = { limit; count }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("count", (Long.to_json v.count));
           Some ("limit", (AccountLimit.to_json v.limit))])
    let parse xml =
      Some
        {
          limit =
            (Xml.required "Limit"
               (Util.option_bind (Xml.member "Limit" xml) AccountLimit.parse));
          count =
            (Xml.required "Count"
               (Util.option_bind (Xml.member "Count" xml) Long.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Limit" ([], (AccountLimit.to_xml v.limit)))])
           @ [Some (Ezxmlm.make_tag "Count" ([], (Long.to_xml v.count)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the requested limit. </p>"]
module DisassociateVPCFromHostedZoneResponse =
  struct
    type t =
      {
      change_info: ChangeInfo.t
        [@ocaml.doc
          "<p>A complex type that describes the changes made to the specified private hosted zone.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the disassociate request.</p>"]
    let make ~change_info  () = { change_info }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("change_info", (ChangeInfo.to_json v.change_info))])
    let parse xml =
      Some
        {
          change_info =
            (Xml.required "ChangeInfo"
               (Util.option_bind (Xml.member "ChangeInfo" xml)
                  ChangeInfo.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "ChangeInfo"
                 ([], (ChangeInfo.to_xml v.change_info)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the disassociate request.</p>"]
module ListResourceRecordSetsResponse =
  struct
    type t =
      {
      resource_record_sets: ResourceRecordSets.t
        [@ocaml.doc
          "<p>Information about multiple resource record sets.</p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A flag that indicates whether more resource record sets remain to be listed. If your results were truncated, you can make a follow-up pagination request by using the <code>NextRecordName</code> element.</p>"];
      next_record_name: String.t option
        [@ocaml.doc
          "<p>If the results were truncated, the name of the next record in the list.</p> <p>This element is present only if <code>IsTruncated</code> is true. </p>"];
      next_record_type: RRType.t option
        [@ocaml.doc
          "<p>If the results were truncated, the type of the next record in the list.</p> <p>This element is present only if <code>IsTruncated</code> is true. </p>"];
      next_record_identifier: String.t option
        [@ocaml.doc
          "<p> <i>Resource record sets that have a routing policy other than simple:</i> If results were truncated for a given DNS name and type, the value of <code>SetIdentifier</code> for the next resource record set that has the current DNS name and type.</p> <p>For information about routing policies, see <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html\">Choosing a Routing Policy</a> in the <i>Amazon Route 53 Developer Guide</i>.</p>"];
      max_items: String.t
        [@ocaml.doc "<p>The maximum number of records you requested.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains list information for the resource record set.</p>"]
    let make ~resource_record_sets  ~is_truncated  ?next_record_name 
      ?next_record_type  ?next_record_identifier  ~max_items  () =
      {
        resource_record_sets;
        is_truncated;
        next_record_name;
        next_record_type;
        next_record_identifier;
        max_items
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Util.option_map v.next_record_identifier
             (fun f -> ("next_record_identifier", (String.to_json f)));
           Util.option_map v.next_record_type
             (fun f -> ("next_record_type", (RRType.to_json f)));
           Util.option_map v.next_record_name
             (fun f -> ("next_record_name", (String.to_json f)));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Some
             ("resource_record_sets",
               (ResourceRecordSets.to_json v.resource_record_sets))])
    let parse xml =
      Some
        {
          resource_record_sets =
            (Xml.required "ResourceRecordSets"
               (Util.option_bind (Xml.member "ResourceRecordSets" xml)
                  ResourceRecordSets.parse));
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          next_record_name =
            (Util.option_bind (Xml.member "NextRecordName" xml) String.parse);
          next_record_type =
            (Util.option_bind (Xml.member "NextRecordType" xml) RRType.parse);
          next_record_identifier =
            (Util.option_bind (Xml.member "NextRecordIdentifier" xml)
               String.parse);
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "ResourceRecordSets"
                           ([], (ResourceRecordSets.to_xml [x]))))
                   v.resource_record_sets))
               @
               [Some
                  (Ezxmlm.make_tag "IsTruncated"
                     ([], (Boolean.to_xml v.is_truncated)))])
              @
              [Util.option_map v.next_record_name
                 (fun f ->
                    Ezxmlm.make_tag "NextRecordName" ([], (String.to_xml f)))])
             @
             [Util.option_map v.next_record_type
                (fun f ->
                   Ezxmlm.make_tag "NextRecordType" ([], (RRType.to_xml f)))])
            @
            [Util.option_map v.next_record_identifier
               (fun f ->
                  Ezxmlm.make_tag "NextRecordIdentifier"
                    ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end[@@ocaml.doc
       "<p>A complex type that contains list information for the resource record set.</p>"]
module UpdateTrafficPolicyInstanceResponse =
  struct
    type t =
      {
      traffic_policy_instance: TrafficPolicyInstance.t
        [@ocaml.doc
          "<p>A complex type that contains settings for the updated traffic policy instance.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the resource record sets that Amazon Route 53 created based on a specified traffic policy.</p>"]
    let make ~traffic_policy_instance  () = { traffic_policy_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("traffic_policy_instance",
                (TrafficPolicyInstance.to_json v.traffic_policy_instance))])
    let parse xml =
      Some
        {
          traffic_policy_instance =
            (Xml.required "TrafficPolicyInstance"
               (Util.option_bind (Xml.member "TrafficPolicyInstance" xml)
                  TrafficPolicyInstance.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "TrafficPolicyInstance"
                 ([],
                   (TrafficPolicyInstance.to_xml v.traffic_policy_instance)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the resource record sets that Amazon Route 53 created based on a specified traffic policy.</p>"]
module DeleteVPCAssociationAuthorizationResponse =
  struct
    type t = unit[@@ocaml.doc "<p>Empty response for the request.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p>Empty response for the request.</p>"]
module GetHealthCheckCountRequest =
  struct
    type t = unit[@@ocaml.doc
                   "<p>A request for the number of health checks that are associated with the current AWS account.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc
       "<p>A request for the number of health checks that are associated with the current AWS account.</p>"]
module DeleteHostedZoneResponse =
  struct
    type t =
      {
      change_info: ChangeInfo.t
        [@ocaml.doc
          "<p>A complex type that contains the ID, the status, and the date and time of a request to delete a hosted zone.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to a <code>DeleteHostedZone</code> request.</p>"]
    let make ~change_info  () = { change_info }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("change_info", (ChangeInfo.to_json v.change_info))])
    let parse xml =
      Some
        {
          change_info =
            (Xml.required "ChangeInfo"
               (Util.option_bind (Xml.member "ChangeInfo" xml)
                  ChangeInfo.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "ChangeInfo"
                 ([], (ChangeInfo.to_xml v.change_info)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response to a <code>DeleteHostedZone</code> request.</p>"]
module DeleteTrafficPolicyResponse =
  struct
    type t = unit[@@ocaml.doc "<p>An empty element.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p>An empty element.</p>"]
module ListTrafficPolicyInstancesByHostedZoneResponse =
  struct
    type t =
      {
      traffic_policy_instances: TrafficPolicyInstances.t
        [@ocaml.doc
          "<p>A list that contains one <code>TrafficPolicyInstance</code> element for each traffic policy instance that matches the elements in the request. </p>"];
      traffic_policy_instance_name_marker: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, <code>TrafficPolicyInstanceNameMarker</code> is the name of the first traffic policy instance in the next group of traffic policy instances.</p>"];
      traffic_policy_instance_type_marker: RRType.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is true, <code>TrafficPolicyInstanceTypeMarker</code> is the DNS type of the resource record sets that are associated with the first traffic policy instance in the next group of traffic policy instances.</p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A flag that indicates whether there are more traffic policy instances to be listed. If the response was truncated, you can get the next group of traffic policy instances by submitting another <code>ListTrafficPolicyInstancesByHostedZone</code> request and specifying the values of <code>HostedZoneIdMarker</code>, <code>TrafficPolicyInstanceNameMarker</code>, and <code>TrafficPolicyInstanceTypeMarker</code> in the corresponding request parameters.</p>"];
      max_items: String.t
        [@ocaml.doc
          "<p>The value that you specified for the <code>MaxItems</code> parameter in the <code>ListTrafficPolicyInstancesByHostedZone</code> request that produced the current response.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the request.</p>"]
    let make ~traffic_policy_instances  ?traffic_policy_instance_name_marker 
      ?traffic_policy_instance_type_marker  ~is_truncated  ~max_items  () =
      {
        traffic_policy_instances;
        traffic_policy_instance_name_marker;
        traffic_policy_instance_type_marker;
        is_truncated;
        max_items
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Util.option_map v.traffic_policy_instance_type_marker
             (fun f ->
                ("traffic_policy_instance_type_marker", (RRType.to_json f)));
           Util.option_map v.traffic_policy_instance_name_marker
             (fun f ->
                ("traffic_policy_instance_name_marker", (String.to_json f)));
           Some
             ("traffic_policy_instances",
               (TrafficPolicyInstances.to_json v.traffic_policy_instances))])
    let parse xml =
      Some
        {
          traffic_policy_instances =
            (Xml.required "TrafficPolicyInstances"
               (Util.option_bind (Xml.member "TrafficPolicyInstances" xml)
                  TrafficPolicyInstances.parse));
          traffic_policy_instance_name_marker =
            (Util.option_bind
               (Xml.member "TrafficPolicyInstanceNameMarker" xml)
               String.parse);
          traffic_policy_instance_type_marker =
            (Util.option_bind
               (Xml.member "TrafficPolicyInstanceTypeMarker" xml)
               RRType.parse);
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "TrafficPolicyInstances"
                          ([], (TrafficPolicyInstances.to_xml [x]))))
                  v.traffic_policy_instances))
              @
              [Util.option_map v.traffic_policy_instance_name_marker
                 (fun f ->
                    Ezxmlm.make_tag "TrafficPolicyInstanceNameMarker"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.traffic_policy_instance_type_marker
                (fun f ->
                   Ezxmlm.make_tag "TrafficPolicyInstanceTypeMarker"
                     ([], (RRType.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "IsTruncated"
                  ([], (Boolean.to_xml v.is_truncated)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the request.</p>"]
module GetReusableDelegationSetLimitResponse =
  struct
    type t =
      {
      limit: ReusableDelegationSetLimit.t
        [@ocaml.doc
          "<p>The current setting for the limit on hosted zones that you can associate with the specified reusable delegation set.</p>"];
      count: Long.t
        [@ocaml.doc
          "<p>The current number of hosted zones that you can associate with the specified reusable delegation set.</p>"]}
    [@@ocaml.doc "<p>A complex type that contains the requested limit. </p>"]
    let make ~limit  ~count  () = { limit; count }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("count", (Long.to_json v.count));
           Some ("limit", (ReusableDelegationSetLimit.to_json v.limit))])
    let parse xml =
      Some
        {
          limit =
            (Xml.required "Limit"
               (Util.option_bind (Xml.member "Limit" xml)
                  ReusableDelegationSetLimit.parse));
          count =
            (Xml.required "Count"
               (Util.option_bind (Xml.member "Count" xml) Long.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Limit"
                  ([], (ReusableDelegationSetLimit.to_xml v.limit)))])
           @ [Some (Ezxmlm.make_tag "Count" ([], (Long.to_xml v.count)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the requested limit. </p>"]
module ListReusableDelegationSetsResponse =
  struct
    type t =
      {
      delegation_sets: DelegationSets.t
        [@ocaml.doc
          "<p>A complex type that contains one <code>DelegationSet</code> element for each reusable delegation set that was created by the current AWS account.</p>"];
      marker: String.t
        [@ocaml.doc
          "<p>For the second and subsequent calls to <code>ListReusableDelegationSets</code>, <code>Marker</code> is the value that you specified for the <code>marker</code> parameter in the request that produced the current response.</p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A flag that indicates whether there are more reusable delegation sets to be listed.</p>"];
      next_marker: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, the value of <code>NextMarker</code> identifies the next reusable delegation set that Amazon Route 53 will return if you submit another <code>ListReusableDelegationSets</code> request and specify the value of <code>NextMarker</code> in the <code>marker</code> parameter.</p>"];
      max_items: String.t
        [@ocaml.doc
          "<p>The value that you specified for the <code>maxitems</code> parameter in the call to <code>ListReusableDelegationSets</code> that produced the current response.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the reusable delegation sets that are associated with the current AWS account.</p>"]
    let make ~delegation_sets  ~marker  ~is_truncated  ?next_marker 
      ~max_items  () =
      { delegation_sets; marker; is_truncated; next_marker; max_items }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Util.option_map v.next_marker
             (fun f -> ("next_marker", (String.to_json f)));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Some ("marker", (String.to_json v.marker));
           Some
             ("delegation_sets", (DelegationSets.to_json v.delegation_sets))])
    let parse xml =
      Some
        {
          delegation_sets =
            (Xml.required "DelegationSets"
               (Util.option_bind (Xml.member "DelegationSets" xml)
                  DelegationSets.parse));
          marker =
            (Xml.required "Marker"
               (Util.option_bind (Xml.member "Marker" xml) String.parse));
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          next_marker =
            (Util.option_bind (Xml.member "NextMarker" xml) String.parse);
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "DelegationSets"
                          ([], (DelegationSets.to_xml [x]))))
                  v.delegation_sets))
              @
              [Some (Ezxmlm.make_tag "Marker" ([], (String.to_xml v.marker)))])
             @
             [Some
                (Ezxmlm.make_tag "IsTruncated"
                   ([], (Boolean.to_xml v.is_truncated)))])
            @
            [Util.option_map v.next_marker
               (fun f -> Ezxmlm.make_tag "NextMarker" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the reusable delegation sets that are associated with the current AWS account.</p>"]
module DeleteHealthCheckResponse =
  struct
    type t = unit[@@ocaml.doc "<p>An empty element.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p>An empty element.</p>"]
module UpdateHostedZoneCommentResponse =
  struct
    type t =
      {
      hosted_zone: HostedZone.t
        [@ocaml.doc
          "<p>A complex type that contains the response to the <code>UpdateHostedZoneComment</code> request.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to the <code>UpdateHostedZoneComment</code> request.</p>"]
    let make ~hosted_zone  () = { hosted_zone }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("hosted_zone", (HostedZone.to_json v.hosted_zone))])
    let parse xml =
      Some
        {
          hosted_zone =
            (Xml.required "HostedZone"
               (Util.option_bind (Xml.member "HostedZone" xml)
                  HostedZone.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "HostedZone"
                 ([], (HostedZone.to_xml v.hosted_zone)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response to the <code>UpdateHostedZoneComment</code> request.</p>"]
module UpdateTrafficPolicyCommentResponse =
  struct
    type t =
      {
      traffic_policy: TrafficPolicy.t
        [@ocaml.doc
          "<p>A complex type that contains settings for the specified traffic policy.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the traffic policy.</p>"]
    let make ~traffic_policy  () = { traffic_policy }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("traffic_policy", (TrafficPolicy.to_json v.traffic_policy))])
    let parse xml =
      Some
        {
          traffic_policy =
            (Xml.required "TrafficPolicy"
               (Util.option_bind (Xml.member "TrafficPolicy" xml)
                  TrafficPolicy.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "TrafficPolicy"
                 ([], (TrafficPolicy.to_xml v.traffic_policy)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the traffic policy.</p>"]
module CreateTrafficPolicyVersionResponse =
  struct
    type t =
      {
      traffic_policy: TrafficPolicy.t
        [@ocaml.doc
          "<p>A complex type that contains settings for the new version of the traffic policy.</p>"];
      location: String.t
        [@ocaml.doc
          "<p>A unique URL that represents a new traffic policy version.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the <code>CreateTrafficPolicyVersion</code> request.</p>"]
    let make ~traffic_policy  ~location  () = { traffic_policy; location }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Some (Headers.Pair ("Location", (String.to_headers v.location)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("location", (String.to_json v.location));
           Some ("traffic_policy", (TrafficPolicy.to_json v.traffic_policy))])
    let parse xml =
      Some
        {
          traffic_policy =
            (Xml.required "TrafficPolicy"
               (Util.option_bind (Xml.member "TrafficPolicy" xml)
                  TrafficPolicy.parse));
          location =
            (Xml.required "Location"
               (Util.option_bind (Xml.member "Location" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "TrafficPolicy"
                  ([], (TrafficPolicy.to_xml v.traffic_policy)))])
           @
           [Some
              (Ezxmlm.make_tag "Location" ([], (String.to_xml v.location)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the <code>CreateTrafficPolicyVersion</code> request.</p>"]
module ListTrafficPoliciesResponse =
  struct
    type t =
      {
      traffic_policy_summaries: TrafficPolicySummaries.t
        [@ocaml.doc
          "<p>A list that contains one <code>TrafficPolicySummary</code> element for each traffic policy that was created by the current AWS account.</p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A flag that indicates whether there are more traffic policies to be listed. If the response was truncated, you can get the next group of traffic policies by submitting another <code>ListTrafficPolicies</code> request and specifying the value of <code>TrafficPolicyIdMarker</code> in the <code>TrafficPolicyIdMarker</code> request parameter.</p>"];
      traffic_policy_id_marker: String.t
        [@ocaml.doc
          "<p>If the value of <code>IsTruncated</code> is <code>true</code>, <code>TrafficPolicyIdMarker</code> is the ID of the first traffic policy in the next group of <code>MaxItems</code> traffic policies.</p>"];
      max_items: String.t
        [@ocaml.doc
          "<p>The value that you specified for the <code>MaxItems</code> parameter in the <code>ListTrafficPolicies</code> request that produced the current response.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the request.</p>"]
    let make ~traffic_policy_summaries  ~is_truncated 
      ~traffic_policy_id_marker  ~max_items  () =
      {
        traffic_policy_summaries;
        is_truncated;
        traffic_policy_id_marker;
        max_items
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Some
             ("traffic_policy_id_marker",
               (String.to_json v.traffic_policy_id_marker));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Some
             ("traffic_policy_summaries",
               (TrafficPolicySummaries.to_json v.traffic_policy_summaries))])
    let parse xml =
      Some
        {
          traffic_policy_summaries =
            (Xml.required "TrafficPolicySummaries"
               (Util.option_bind (Xml.member "TrafficPolicySummaries" xml)
                  TrafficPolicySummaries.parse));
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          traffic_policy_id_marker =
            (Xml.required "TrafficPolicyIdMarker"
               (Util.option_bind (Xml.member "TrafficPolicyIdMarker" xml)
                  String.parse));
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "TrafficPolicySummaries"
                         ([], (TrafficPolicySummaries.to_xml [x]))))
                 v.traffic_policy_summaries))
             @
             [Some
                (Ezxmlm.make_tag "IsTruncated"
                   ([], (Boolean.to_xml v.is_truncated)))])
            @
            [Some
               (Ezxmlm.make_tag "TrafficPolicyIdMarker"
                  ([], (String.to_xml v.traffic_policy_id_marker)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the request.</p>"]
module GetHostedZoneResponse =
  struct
    type t =
      {
      hosted_zone: HostedZone.t
        [@ocaml.doc
          "<p>A complex type that contains general information about the specified hosted zone.</p>"];
      delegation_set: DelegationSet.t option
        [@ocaml.doc
          "<p>A complex type that lists the Amazon Route 53 name servers for the specified hosted zone.</p>"];
      v_p_cs: VPCs.t
        [@ocaml.doc
          "<p>A complex type that contains information about the VPCs that are associated with the specified hosted zone.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contain the response to a <code>GetHostedZone</code> request.</p>"]
    let make ~hosted_zone  ?delegation_set  ?(v_p_cs= [])  () =
      { hosted_zone; delegation_set; v_p_cs }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("v_p_cs", (VPCs.to_json v.v_p_cs));
           Util.option_map v.delegation_set
             (fun f -> ("delegation_set", (DelegationSet.to_json f)));
           Some ("hosted_zone", (HostedZone.to_json v.hosted_zone))])
    let parse xml =
      Some
        {
          hosted_zone =
            (Xml.required "HostedZone"
               (Util.option_bind (Xml.member "HostedZone" xml)
                  HostedZone.parse));
          delegation_set =
            (Util.option_bind (Xml.member "DelegationSet" xml)
               DelegationSet.parse);
          v_p_cs =
            (Util.of_option []
               (Util.option_bind (Xml.member "VPCs" xml) VPCs.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "HostedZone"
                   ([], (HostedZone.to_xml v.hosted_zone)))])
            @
            [Util.option_map v.delegation_set
               (fun f ->
                  Ezxmlm.make_tag "DelegationSet"
                    ([], (DelegationSet.to_xml f)))])
           @
           (List.map
              (fun x -> Some (Ezxmlm.make_tag "VPCs" ([], (VPCs.to_xml [x]))))
              v.v_p_cs))
  end[@@ocaml.doc
       "<p>A complex type that contain the response to a <code>GetHostedZone</code> request.</p>"]
module CreateTrafficPolicyResponse =
  struct
    type t =
      {
      traffic_policy: TrafficPolicy.t
        [@ocaml.doc
          "<p>A complex type that contains settings for the new traffic policy.</p>"];
      location: String.t
        [@ocaml.doc
          "<p>A unique URL that represents a new traffic policy.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the <code>CreateTrafficPolicy</code> request.</p>"]
    let make ~traffic_policy  ~location  () = { traffic_policy; location }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Some (Headers.Pair ("Location", (String.to_headers v.location)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("location", (String.to_json v.location));
           Some ("traffic_policy", (TrafficPolicy.to_json v.traffic_policy))])
    let parse xml =
      Some
        {
          traffic_policy =
            (Xml.required "TrafficPolicy"
               (Util.option_bind (Xml.member "TrafficPolicy" xml)
                  TrafficPolicy.parse));
          location =
            (Xml.required "Location"
               (Util.option_bind (Xml.member "Location" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "TrafficPolicy"
                  ([], (TrafficPolicy.to_xml v.traffic_policy)))])
           @
           [Some
              (Ezxmlm.make_tag "Location" ([], (String.to_xml v.location)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the <code>CreateTrafficPolicy</code> request.</p>"]
module ListTrafficPolicyInstancesByPolicyResponse =
  struct
    type t =
      {
      traffic_policy_instances: TrafficPolicyInstances.t
        [@ocaml.doc
          "<p>A list that contains one <code>TrafficPolicyInstance</code> element for each traffic policy instance that matches the elements in the request.</p>"];
      hosted_zone_id_marker: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, <code>HostedZoneIdMarker</code> is the ID of the hosted zone of the first traffic policy instance in the next group of traffic policy instances.</p>"];
      traffic_policy_instance_name_marker: String.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, <code>TrafficPolicyInstanceNameMarker</code> is the name of the first traffic policy instance in the next group of <code>MaxItems</code> traffic policy instances.</p>"];
      traffic_policy_instance_type_marker: RRType.t option
        [@ocaml.doc
          "<p>If <code>IsTruncated</code> is <code>true</code>, <code>TrafficPolicyInstanceTypeMarker</code> is the DNS type of the resource record sets that are associated with the first traffic policy instance in the next group of <code>MaxItems</code> traffic policy instances.</p>"];
      is_truncated: Boolean.t
        [@ocaml.doc
          "<p>A flag that indicates whether there are more traffic policy instances to be listed. If the response was truncated, you can get the next group of traffic policy instances by calling <code>ListTrafficPolicyInstancesByPolicy</code> again and specifying the values of the <code>HostedZoneIdMarker</code>, <code>TrafficPolicyInstanceNameMarker</code>, and <code>TrafficPolicyInstanceTypeMarker</code> elements in the corresponding request parameters.</p>"];
      max_items: String.t
        [@ocaml.doc
          "<p>The value that you specified for the <code>MaxItems</code> parameter in the call to <code>ListTrafficPolicyInstancesByPolicy</code> that produced the current response.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response information for the request.</p>"]
    let make ~traffic_policy_instances  ?hosted_zone_id_marker 
      ?traffic_policy_instance_name_marker 
      ?traffic_policy_instance_type_marker  ~is_truncated  ~max_items  () =
      {
        traffic_policy_instances;
        hosted_zone_id_marker;
        traffic_policy_instance_name_marker;
        traffic_policy_instance_type_marker;
        is_truncated;
        max_items
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("max_items", (String.to_json v.max_items));
           Some ("is_truncated", (Boolean.to_json v.is_truncated));
           Util.option_map v.traffic_policy_instance_type_marker
             (fun f ->
                ("traffic_policy_instance_type_marker", (RRType.to_json f)));
           Util.option_map v.traffic_policy_instance_name_marker
             (fun f ->
                ("traffic_policy_instance_name_marker", (String.to_json f)));
           Util.option_map v.hosted_zone_id_marker
             (fun f -> ("hosted_zone_id_marker", (String.to_json f)));
           Some
             ("traffic_policy_instances",
               (TrafficPolicyInstances.to_json v.traffic_policy_instances))])
    let parse xml =
      Some
        {
          traffic_policy_instances =
            (Xml.required "TrafficPolicyInstances"
               (Util.option_bind (Xml.member "TrafficPolicyInstances" xml)
                  TrafficPolicyInstances.parse));
          hosted_zone_id_marker =
            (Util.option_bind (Xml.member "HostedZoneIdMarker" xml)
               String.parse);
          traffic_policy_instance_name_marker =
            (Util.option_bind
               (Xml.member "TrafficPolicyInstanceNameMarker" xml)
               String.parse);
          traffic_policy_instance_type_marker =
            (Util.option_bind
               (Xml.member "TrafficPolicyInstanceTypeMarker" xml)
               RRType.parse);
          is_truncated =
            (Xml.required "IsTruncated"
               (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse));
          max_items =
            (Xml.required "MaxItems"
               (Util.option_bind (Xml.member "MaxItems" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "TrafficPolicyInstances"
                           ([], (TrafficPolicyInstances.to_xml [x]))))
                   v.traffic_policy_instances))
               @
               [Util.option_map v.hosted_zone_id_marker
                  (fun f ->
                     Ezxmlm.make_tag "HostedZoneIdMarker"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.traffic_policy_instance_name_marker
                 (fun f ->
                    Ezxmlm.make_tag "TrafficPolicyInstanceNameMarker"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.traffic_policy_instance_type_marker
                (fun f ->
                   Ezxmlm.make_tag "TrafficPolicyInstanceTypeMarker"
                     ([], (RRType.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "IsTruncated"
                  ([], (Boolean.to_xml v.is_truncated)))])
           @
           [Some
              (Ezxmlm.make_tag "MaxItems" ([], (String.to_xml v.max_items)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response information for the request.</p>"]
module TestDNSAnswerResponse =
  struct
    type t =
      {
      nameserver: String.t
        [@ocaml.doc
          "<p>The Amazon Route 53 name server used to respond to the request.</p>"];
      record_name: String.t
        [@ocaml.doc
          "<p>The name of the resource record set that you submitted a request for.</p>"];
      record_type: RRType.t
        [@ocaml.doc
          "<p>The type of the resource record set that you submitted a request for.</p>"];
      record_data: RecordData.t
        [@ocaml.doc
          "<p>A list that contains values that Amazon Route 53 returned for this resource record set.</p>"];
      response_code: String.t
        [@ocaml.doc
          "<p>A code that indicates whether the request is valid or not. The most common response code is <code>NOERROR</code>, meaning that the request is valid. If the response is not valid, Amazon Route 53 returns a response code that describes the error. For a list of possible response codes, see <a href=\"http://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6\">DNS RCODES</a> on the IANA website. </p>"];
      protocol: String.t
        [@ocaml.doc
          "<p>The protocol that Amazon Route 53 used to respond to the request, either <code>UDP</code> or <code>TCP</code>. </p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains the response to a <code>TestDNSAnswer</code> request. </p>"]
    let make ~nameserver  ~record_name  ~record_type  ~record_data 
      ~response_code  ~protocol  () =
      {
        nameserver;
        record_name;
        record_type;
        record_data;
        response_code;
        protocol
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("protocol", (String.to_json v.protocol));
           Some ("response_code", (String.to_json v.response_code));
           Some ("record_data", (RecordData.to_json v.record_data));
           Some ("record_type", (RRType.to_json v.record_type));
           Some ("record_name", (String.to_json v.record_name));
           Some ("nameserver", (String.to_json v.nameserver))])
    let parse xml =
      Some
        {
          nameserver =
            (Xml.required "Nameserver"
               (Util.option_bind (Xml.member "Nameserver" xml) String.parse));
          record_name =
            (Xml.required "RecordName"
               (Util.option_bind (Xml.member "RecordName" xml) String.parse));
          record_type =
            (Xml.required "RecordType"
               (Util.option_bind (Xml.member "RecordType" xml) RRType.parse));
          record_data =
            (Xml.required "RecordData"
               (Util.option_bind (Xml.member "RecordData" xml)
                  RecordData.parse));
          response_code =
            (Xml.required "ResponseCode"
               (Util.option_bind (Xml.member "ResponseCode" xml) String.parse));
          protocol =
            (Xml.required "Protocol"
               (Util.option_bind (Xml.member "Protocol" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "Nameserver"
                      ([], (String.to_xml v.nameserver)))])
               @
               [Some
                  (Ezxmlm.make_tag "RecordName"
                     ([], (String.to_xml v.record_name)))])
              @
              [Some
                 (Ezxmlm.make_tag "RecordType"
                    ([], (RRType.to_xml v.record_type)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "RecordData"
                        ([], (RecordData.to_xml [x])))) v.record_data))
            @
            [Some
               (Ezxmlm.make_tag "ResponseCode"
                  ([], (String.to_xml v.response_code)))])
           @
           [Some
              (Ezxmlm.make_tag "Protocol" ([], (String.to_xml v.protocol)))])
  end[@@ocaml.doc
       "<p>A complex type that contains the response to a <code>TestDNSAnswer</code> request. </p>"]