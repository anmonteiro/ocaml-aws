open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyVpcAttributeRequest =
  struct
    type t =
      {
      enable_dns_hostnames: AttributeBooleanValue.t option
        [@ocaml.doc
          "<p>Indicates whether the instances launched in the VPC get DNS hostnames. If enabled, instances in the VPC get DNS hostnames; otherwise, they do not.</p> <p>You cannot modify the DNS resolution and DNS hostnames attributes in the same request. Use separate requests for each attribute. You can only enable DNS hostnames if you've enabled DNS support.</p>"];
      enable_dns_support: AttributeBooleanValue.t option
        [@ocaml.doc
          "<p>Indicates whether the DNS resolution is supported for the VPC. If enabled, queries to the Amazon provided DNS server at the 169.254.169.253 IP address, or the reserved IP address at the base of the VPC network range \"plus two\" succeed. If disabled, the Amazon provided DNS service in the VPC that resolves public DNS hostnames to IP addresses is not enabled.</p> <p>You cannot modify the DNS resolution and DNS hostnames attributes in the same request. Use separate requests for each attribute.</p>"];
      vpc_id: String.t [@ocaml.doc "<p>The ID of the VPC.</p>"]}
    let make ?enable_dns_hostnames  ?enable_dns_support  ~vpc_id  () =
      { enable_dns_hostnames; enable_dns_support; vpc_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("VpcId", (String.to_query v.vpc_id)));
           Util.option_map v.enable_dns_support
             (fun f ->
                Query.Pair
                  ("EnableDnsSupport", (AttributeBooleanValue.to_query f)));
           Util.option_map v.enable_dns_hostnames
             (fun f ->
                Query.Pair
                  ("EnableDnsHostnames", (AttributeBooleanValue.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("vpc_id", (String.to_json v.vpc_id));
           Util.option_map v.enable_dns_support
             (fun f ->
                ("enable_dns_support", (AttributeBooleanValue.to_json f)));
           Util.option_map v.enable_dns_hostnames
             (fun f ->
                ("enable_dns_hostnames", (AttributeBooleanValue.to_json f)))])
    let parse xml =
      Some
        {
          enable_dns_hostnames =
            (Util.option_bind (Xml.member "EnableDnsHostnames" xml)
               AttributeBooleanValue.parse);
          enable_dns_support =
            (Util.option_bind (Xml.member "EnableDnsSupport" xml)
               AttributeBooleanValue.parse);
          vpc_id =
            (Xml.required "vpcId"
               (Util.option_bind (Xml.member "vpcId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.enable_dns_hostnames
                (fun f ->
                   Ezxmlm.make_tag "EnableDnsHostnames"
                     ([], (AttributeBooleanValue.to_xml f)))])
            @
            [Util.option_map v.enable_dns_support
               (fun f ->
                  Ezxmlm.make_tag "EnableDnsSupport"
                    ([], (AttributeBooleanValue.to_xml f)))])
           @ [Some (Ezxmlm.make_tag "vpcId" ([], (String.to_xml v.vpc_id)))])
  end
module Output = Aws.BaseTypes.Unit
type input = ModifyVpcAttributeRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ModifyVpcAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyVpcAttributeRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyVpcAttributeRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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