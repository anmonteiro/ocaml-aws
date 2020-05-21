open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeIdentityIdFormatRequest =
  struct
    type t =
      {
      principal_arn: String.t
        [@ocaml.doc
          "<p>The ARN of the principal, which can be an IAM role, IAM user, or the root user.</p>"];
      resource: String.t option
        [@ocaml.doc
          "<p>The type of resource: <code>bundle</code> | <code>conversion-task</code> | <code>customer-gateway</code> | <code>dhcp-options</code> | <code>elastic-ip-allocation</code> | <code>elastic-ip-association</code> | <code>export-task</code> | <code>flow-log</code> | <code>image</code> | <code>import-task</code> | <code>instance</code> | <code>internet-gateway</code> | <code>network-acl</code> | <code>network-acl-association</code> | <code>network-interface</code> | <code>network-interface-attachment</code> | <code>prefix-list</code> | <code>reservation</code> | <code>route-table</code> | <code>route-table-association</code> | <code>security-group</code> | <code>snapshot</code> | <code>subnet</code> | <code>subnet-cidr-block-association</code> | <code>volume</code> | <code>vpc</code> | <code>vpc-cidr-block-association</code> | <code>vpc-endpoint</code> | <code>vpc-peering-connection</code> | <code>vpn-connection</code> | <code>vpn-gateway</code> </p>"]}
    let make ~principal_arn  ?resource  () = { principal_arn; resource }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.resource
              (fun f -> Query.Pair ("Resource", (String.to_query f)));
           Some
             (Query.Pair ("PrincipalArn", (String.to_query v.principal_arn)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.resource
              (fun f -> ("resource", (String.to_json f)));
           Some ("principal_arn", (String.to_json v.principal_arn))])
    let parse xml =
      Some
        {
          principal_arn =
            (Xml.required "principalArn"
               (Util.option_bind (Xml.member "principalArn" xml) String.parse));
          resource =
            (Util.option_bind (Xml.member "resource" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "principalArn"
                  ([], (String.to_xml v.principal_arn)))])
           @
           [Util.option_map v.resource
              (fun f -> Ezxmlm.make_tag "resource" ([], (String.to_xml f)))])
  end
module DescribeIdentityIdFormatResult = DescribeIdentityIdFormatResult
type input = DescribeIdentityIdFormatRequest.t
type output = DescribeIdentityIdFormatResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["DescribeIdentityIdFormat"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeIdentityIdFormatRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeIdentityIdFormatRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeIdentityIdFormatResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeIdentityIdFormatResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeIdentityIdFormatResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeIdentityIdFormatResult - missing field in body or children: "
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