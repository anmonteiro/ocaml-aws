open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateHealthCheckRequest =
  struct
    type t =
      {
      health_check_id: String.t
        [@ocaml.doc
          "<p>The ID for the health check for which you want detailed information. When you created the health check, <code>CreateHealthCheck</code> returned the ID in the response, in the <code>HealthCheckId</code> element.</p>"];
      health_check_version: Long.t option
        [@ocaml.doc
          "<p>A sequential counter that Amazon Route 53 sets to <code>1</code> when you create a health check and increments by 1 each time you update settings for the health check.</p> <p>We recommend that you use <code>GetHealthCheck</code> or <code>ListHealthChecks</code> to get the current value of <code>HealthCheckVersion</code> for the health check that you want to update, and that you include that value in your <code>UpdateHealthCheck</code> request. This prevents Route 53 from overwriting an intervening update:</p> <ul> <li> <p>If the value in the <code>UpdateHealthCheck</code> request matches the value of <code>HealthCheckVersion</code> in the health check, Route 53 updates the health check with the new settings.</p> </li> <li> <p>If the value of <code>HealthCheckVersion</code> in the health check is greater, the health check was changed after you got the version number. Route 53 does not update the health check, and it returns a <code>HealthCheckVersionMismatch</code> error.</p> </li> </ul>"];
      i_p_address: String.t option
        [@ocaml.doc
          "<p>The IPv4 or IPv6 IP address for the endpoint that you want Amazon Route 53 to perform health checks on. If you don't specify a value for <code>IPAddress</code>, Route 53 sends a DNS request to resolve the domain name that you specify in <code>FullyQualifiedDomainName</code> at the interval that you specify in <code>RequestInterval</code>. Using an IP address that is returned by DNS, Route 53 then checks the health of the endpoint.</p> <p>Use one of the following formats for the value of <code>IPAddress</code>: </p> <ul> <li> <p> <b>IPv4 address</b>: four values between 0 and 255, separated by periods (.), for example, <code>192.0.2.44</code>.</p> </li> <li> <p> <b>IPv6 address</b>: eight groups of four hexadecimal values, separated by colons (:), for example, <code>2001:0db8:85a3:0000:0000:abcd:0001:2345</code>. You can also shorten IPv6 addresses as described in RFC 5952, for example, <code>2001:db8:85a3::abcd:1:2345</code>.</p> </li> </ul> <p>If the endpoint is an EC2 instance, we recommend that you create an Elastic IP address, associate it with your EC2 instance, and specify the Elastic IP address for <code>IPAddress</code>. This ensures that the IP address of your instance never changes. For more information, see the applicable documentation:</p> <ul> <li> <p>Linux: <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html\">Elastic IP Addresses (EIP)</a> in the <i>Amazon EC2 User Guide for Linux Instances</i> </p> </li> <li> <p>Windows: <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/elastic-ip-addresses-eip.html\">Elastic IP Addresses (EIP)</a> in the <i>Amazon EC2 User Guide for Windows Instances</i> </p> </li> </ul> <note> <p>If a health check already has a value for <code>IPAddress</code>, you can change the value. However, you can't update an existing health check to add or remove the value of <code>IPAddress</code>. </p> </note> <p>For more information, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_UpdateHealthCheck.html#Route53-UpdateHealthCheck-request-FullyQualifiedDomainName\">FullyQualifiedDomainName</a>. </p> <p>Constraints: Route 53 can't check the health of endpoints for which the IP address is in local, private, non-routable, or multicast ranges. For more information about IP addresses for which you can't create health checks, see the following documents:</p> <ul> <li> <p> <a href=\"https://tools.ietf.org/html/rfc5735\">RFC 5735, Special Use IPv4 Addresses</a> </p> </li> <li> <p> <a href=\"https://tools.ietf.org/html/rfc6598\">RFC 6598, IANA-Reserved IPv4 Prefix for Shared Address Space</a> </p> </li> <li> <p> <a href=\"https://tools.ietf.org/html/rfc5156\">RFC 5156, Special-Use IPv6 Addresses</a> </p> </li> </ul>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port on the endpoint on which you want Amazon Route 53 to perform health checks.</p>"];
      resource_path: String.t option
        [@ocaml.doc
          "<p>The path that you want Amazon Route 53 to request when performing health checks. The path can be any value for which your endpoint will return an HTTP status code of 2xx or 3xx when the endpoint is healthy, for example the file /docs/route53-health-check.html. You can also include query string parameters, for example, <code>/welcome.html?language=jp&amp;login=y</code>. </p> <p>Specify this value only if you want to change it.</p>"];
      fully_qualified_domain_name: String.t option
        [@ocaml.doc
          "<p>Amazon Route 53 behavior depends on whether you specify a value for <code>IPAddress</code>.</p> <note> <p>If a health check already has a value for <code>IPAddress</code>, you can change the value. However, you can't update an existing health check to add or remove the value of <code>IPAddress</code>. </p> </note> <p> <b>If you specify a value for</b> <code>IPAddress</code>:</p> <p>Route 53 sends health check requests to the specified IPv4 or IPv6 address and passes the value of <code>FullyQualifiedDomainName</code> in the <code>Host</code> header for all health checks except TCP health checks. This is typically the fully qualified DNS name of the endpoint on which you want Route 53 to perform health checks.</p> <p>When Route 53 checks the health of an endpoint, here is how it constructs the <code>Host</code> header:</p> <ul> <li> <p>If you specify a value of <code>80</code> for <code>Port</code> and <code>HTTP</code> or <code>HTTP_STR_MATCH</code> for <code>Type</code>, Route 53 passes the value of <code>FullyQualifiedDomainName</code> to the endpoint in the <code>Host</code> header.</p> </li> <li> <p>If you specify a value of <code>443</code> for <code>Port</code> and <code>HTTPS</code> or <code>HTTPS_STR_MATCH</code> for <code>Type</code>, Route 53 passes the value of <code>FullyQualifiedDomainName</code> to the endpoint in the <code>Host</code> header.</p> </li> <li> <p>If you specify another value for <code>Port</code> and any value except <code>TCP</code> for <code>Type</code>, Route 53 passes <i> <code>FullyQualifiedDomainName</code>:<code>Port</code> </i> to the endpoint in the <code>Host</code> header.</p> </li> </ul> <p>If you don't specify a value for <code>FullyQualifiedDomainName</code>, Route 53 substitutes the value of <code>IPAddress</code> in the <code>Host</code> header in each of the above cases.</p> <p> <b>If you don't specify a value for</b> <code>IPAddress</code>:</p> <p>If you don't specify a value for <code>IPAddress</code>, Route 53 sends a DNS request to the domain that you specify in <code>FullyQualifiedDomainName</code> at the interval you specify in <code>RequestInterval</code>. Using an IPv4 address that is returned by DNS, Route 53 then checks the health of the endpoint.</p> <note> <p>If you don't specify a value for <code>IPAddress</code>, Route 53 uses only IPv4 to send health checks to the endpoint. If there's no resource record set with a type of A for the name that you specify for <code>FullyQualifiedDomainName</code>, the health check fails with a \"DNS resolution failed\" error.</p> </note> <p>If you want to check the health of weighted, latency, or failover resource record sets and you choose to specify the endpoint only by <code>FullyQualifiedDomainName</code>, we recommend that you create a separate health check for each endpoint. For example, create a health check for each HTTP server that is serving content for www.example.com. For the value of <code>FullyQualifiedDomainName</code>, specify the domain name of the server (such as <code>us-east-2-www.example.com</code>), not the name of the resource record sets (www.example.com).</p> <important> <p>In this configuration, if the value of <code>FullyQualifiedDomainName</code> matches the name of the resource record sets and you then associate the health check with those resource record sets, health check results will be unpredictable.</p> </important> <p>In addition, if the value of <code>Type</code> is <code>HTTP</code>, <code>HTTPS</code>, <code>HTTP_STR_MATCH</code>, or <code>HTTPS_STR_MATCH</code>, Route 53 passes the value of <code>FullyQualifiedDomainName</code> in the <code>Host</code> header, as it does when you specify a value for <code>IPAddress</code>. If the value of <code>Type</code> is <code>TCP</code>, Route 53 doesn't pass a <code>Host</code> header.</p>"];
      search_string: String.t option
        [@ocaml.doc
          "<p>If the value of <code>Type</code> is <code>HTTP_STR_MATCH</code> or <code>HTTP_STR_MATCH</code>, the string that you want Amazon Route 53 to search for in the response body from the specified resource. If the string appears in the response body, Route 53 considers the resource healthy. (You can't change the value of <code>Type</code> when you update a health check.)</p>"];
      failure_threshold: Integer.t option
        [@ocaml.doc
          "<p>The number of consecutive health checks that an endpoint must pass or fail for Amazon Route 53 to change the current status of the endpoint from unhealthy to healthy or vice versa. For more information, see <a href=\"http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-determining-health-of-endpoints.html\">How Amazon Route 53 Determines Whether an Endpoint Is Healthy</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>If you don't specify a value for <code>FailureThreshold</code>, the default value is three health checks.</p>"];
      inverted: Boolean.t option
        [@ocaml.doc
          "<p>Specify whether you want Amazon Route 53 to invert the status of a health check, for example, to consider a health check unhealthy when it otherwise would be considered healthy.</p>"];
      disabled: Boolean.t option
        [@ocaml.doc
          "<p>Stops Route 53 from performing health checks. When you disable a health check, here's what happens:</p> <ul> <li> <p> <b>Health checks that check the health of endpoints:</b> Route 53 stops submitting requests to your application, server, or other resource.</p> </li> <li> <p> <b>Calculated health checks:</b> Route 53 stops aggregating the status of the referenced health checks.</p> </li> <li> <p> <b>Health checks that monitor CloudWatch alarms:</b> Route 53 stops monitoring the corresponding CloudWatch metrics.</p> </li> </ul> <p>After you disable a health check, Route 53 considers the status of the health check to always be healthy. If you configured DNS failover, Route 53 continues to route traffic to the corresponding resources. If you want to stop routing traffic to a resource, change the value of <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_UpdateHealthCheck.html#Route53-UpdateHealthCheck-request-Inverted\">Inverted</a>. </p> <p>Charges for a health check still apply when the health check is disabled. For more information, see <a href=\"http://aws.amazon.com/route53/pricing/\">Amazon Route 53 Pricing</a>.</p>"];
      health_threshold: Integer.t option
        [@ocaml.doc
          "<p>The number of child health checks that are associated with a <code>CALCULATED</code> health that Amazon Route 53 must consider healthy for the <code>CALCULATED</code> health check to be considered healthy. To specify the child health checks that you want to associate with a <code>CALCULATED</code> health check, use the <code>ChildHealthChecks</code> and <code>ChildHealthCheck</code> elements.</p> <p>Note the following:</p> <ul> <li> <p>If you specify a number greater than the number of child health checks, Route 53 always considers this health check to be unhealthy.</p> </li> <li> <p>If you specify <code>0</code>, Route 53 always considers this health check to be healthy.</p> </li> </ul>"];
      child_health_checks: ChildHealthCheckList.t
        [@ocaml.doc
          "<p>A complex type that contains one <code>ChildHealthCheck</code> element for each health check that you want to associate with a <code>CALCULATED</code> health check.</p>"];
      enable_s_n_i: Boolean.t option
        [@ocaml.doc
          "<p>Specify whether you want Amazon Route 53 to send the value of <code>FullyQualifiedDomainName</code> to the endpoint in the <code>client_hello</code> message during <code>TLS</code> negotiation. This allows the endpoint to respond to <code>HTTPS</code> health check requests with the applicable SSL/TLS certificate.</p> <p>Some endpoints require that HTTPS requests include the host name in the <code>client_hello</code> message. If you don't enable SNI, the status of the health check will be SSL alert <code>handshake_failure</code>. A health check can also have that status for other reasons. If SNI is enabled and you're still getting the error, check the SSL/TLS configuration on your endpoint and confirm that your certificate is valid.</p> <p>The SSL/TLS certificate on your endpoint includes a domain name in the <code>Common Name</code> field and possibly several more in the <code>Subject Alternative Names</code> field. One of the domain names in the certificate should match the value that you specify for <code>FullyQualifiedDomainName</code>. If the endpoint responds to the <code>client_hello</code> message with a certificate that does not include the domain name that you specified in <code>FullyQualifiedDomainName</code>, a health checker will retry the handshake. In the second attempt, the health checker will omit <code>FullyQualifiedDomainName</code> from the <code>client_hello</code> message.</p>"];
      regions: HealthCheckRegionList.t
        [@ocaml.doc
          "<p>A complex type that contains one <code>Region</code> element for each region that you want Amazon Route 53 health checkers to check the specified endpoint from.</p>"];
      alarm_identifier: AlarmIdentifier.t option
        [@ocaml.doc
          "<p>A complex type that identifies the CloudWatch alarm that you want Amazon Route 53 health checkers to use to determine whether the specified health check is healthy.</p>"];
      insufficient_data_health_status: InsufficientDataHealthStatus.t option
        [@ocaml.doc
          "<p>When CloudWatch has insufficient data about the metric to determine the alarm state, the status that you want Amazon Route 53 to assign to the health check:</p> <ul> <li> <p> <code>Healthy</code>: Route 53 considers the health check to be healthy.</p> </li> <li> <p> <code>Unhealthy</code>: Route 53 considers the health check to be unhealthy.</p> </li> <li> <p> <code>LastKnownStatus</code>: Route 53 uses the status of the health check from the last time CloudWatch had sufficient data to determine the alarm state. For new health checks that have no last known status, the default status for the health check is healthy.</p> </li> </ul>"];
      reset_elements: ResettableElementNameList.t
        [@ocaml.doc
          "<p>A complex type that contains one <code>ResettableElementName</code> element for each element that you want to reset to the default value. Valid values for <code>ResettableElementName</code> include the following:</p> <ul> <li> <p> <code>ChildHealthChecks</code>: Amazon Route 53 resets <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_HealthCheckConfig.html#Route53-Type-HealthCheckConfig-ChildHealthChecks\">ChildHealthChecks</a> to null.</p> </li> <li> <p> <code>FullyQualifiedDomainName</code>: Route 53 resets <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_UpdateHealthCheck.html#Route53-UpdateHealthCheck-request-FullyQualifiedDomainName\">FullyQualifiedDomainName</a>. to null.</p> </li> <li> <p> <code>Regions</code>: Route 53 resets the <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_HealthCheckConfig.html#Route53-Type-HealthCheckConfig-Regions\">Regions</a> list to the default set of regions. </p> </li> <li> <p> <code>ResourcePath</code>: Route 53 resets <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_HealthCheckConfig.html#Route53-Type-HealthCheckConfig-ResourcePath\">ResourcePath</a> to null.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about a request to update a health check.</p>"]
    let make ~health_check_id  ?health_check_version  ?i_p_address  ?port 
      ?resource_path  ?fully_qualified_domain_name  ?search_string 
      ?failure_threshold  ?inverted  ?disabled  ?health_threshold 
      ?(child_health_checks= [])  ?enable_s_n_i  ?(regions= []) 
      ?alarm_identifier  ?insufficient_data_health_status  ?(reset_elements=
      [])  () =
      {
        health_check_id;
        health_check_version;
        i_p_address;
        port;
        resource_path;
        fully_qualified_domain_name;
        search_string;
        failure_threshold;
        inverted;
        disabled;
        health_threshold;
        child_health_checks;
        enable_s_n_i;
        regions;
        alarm_identifier;
        insufficient_data_health_status;
        reset_elements
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("reset_elements",
                (ResettableElementNameList.to_json v.reset_elements));
           Util.option_map v.insufficient_data_health_status
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
           Util.option_map v.failure_threshold
             (fun f -> ("failure_threshold", (Integer.to_json f)));
           Util.option_map v.search_string
             (fun f -> ("search_string", (String.to_json f)));
           Util.option_map v.fully_qualified_domain_name
             (fun f -> ("fully_qualified_domain_name", (String.to_json f)));
           Util.option_map v.resource_path
             (fun f -> ("resource_path", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.i_p_address
             (fun f -> ("i_p_address", (String.to_json f)));
           Util.option_map v.health_check_version
             (fun f -> ("health_check_version", (Long.to_json f)));
           Some ("health_check_id", (String.to_json v.health_check_id))])
    let parse xml =
      Some
        {
          health_check_id =
            (Xml.required "HealthCheckId"
               (Util.option_bind (Xml.member "HealthCheckId" xml)
                  String.parse));
          health_check_version =
            (Util.option_bind (Xml.member "HealthCheckVersion" xml)
               Long.parse);
          i_p_address =
            (Util.option_bind (Xml.member "IPAddress" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          resource_path =
            (Util.option_bind (Xml.member "ResourcePath" xml) String.parse);
          fully_qualified_domain_name =
            (Util.option_bind (Xml.member "FullyQualifiedDomainName" xml)
               String.parse);
          search_string =
            (Util.option_bind (Xml.member "SearchString" xml) String.parse);
          failure_threshold =
            (Util.option_bind (Xml.member "FailureThreshold" xml)
               Integer.parse);
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
               InsufficientDataHealthStatus.parse);
          reset_elements =
            (Util.of_option []
               (Util.option_bind (Xml.member "ResetElements" xml)
                  ResettableElementNameList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((([] @
                           [Some
                              (Ezxmlm.make_tag "HealthCheckId"
                                 ([], (String.to_xml v.health_check_id)))])
                          @
                          [Util.option_map v.health_check_version
                             (fun f ->
                                Ezxmlm.make_tag "HealthCheckVersion"
                                  ([], (Long.to_xml f)))])
                         @
                         [Util.option_map v.i_p_address
                            (fun f ->
                               Ezxmlm.make_tag "IPAddress"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.port
                           (fun f ->
                              Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
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
                    [Util.option_map v.failure_threshold
                       (fun f ->
                          Ezxmlm.make_tag "FailureThreshold"
                            ([], (Integer.to_xml f)))])
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
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ResetElements"
                      ([], (ResettableElementNameList.to_xml [x]))))
              v.reset_elements))
  end[@@ocaml.doc
       "<p>A complex type that contains information about a request to update a health check.</p>"]
module UpdateHealthCheckResponse = UpdateHealthCheckResponse
type input = UpdateHealthCheckRequest.t
type output = UpdateHealthCheckResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/2013-04-01/healthcheck/" ^
               req.UpdateHealthCheckRequest.health_check_id)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (UpdateHealthCheckRequest.to_query req)))) in
  (`POST, uri, (Headers.render (UpdateHealthCheckRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure "Could not find well formed UpdateHealthCheckResponse.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp UpdateHealthCheckResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed UpdateHealthCheckResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UpdateHealthCheckResponse - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None