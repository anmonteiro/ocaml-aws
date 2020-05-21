open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateSecurityGroupRequest =
  struct
    type t =
      {
      description: String.t
        [@ocaml.doc
          "<p>A description for the security group. This is informational only.</p> <p>Constraints: Up to 255 characters in length</p> <p>Constraints for EC2-Classic: ASCII characters</p> <p>Constraints for EC2-VPC: a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=&amp;;{}!$*</p>"];
      group_name: String.t
        [@ocaml.doc
          "<p>The name of the security group.</p> <p>Constraints: Up to 255 characters in length. Cannot start with <code>sg-</code>.</p> <p>Constraints for EC2-Classic: ASCII characters</p> <p>Constraints for EC2-VPC: a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=&amp;;{}!$*</p>"];
      vpc_id: String.t option
        [@ocaml.doc
          "<p>[EC2-VPC] The ID of the VPC. Required for EC2-VPC.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~description  ~group_name  ?vpc_id  ?dry_run  () =
      { description; group_name; vpc_id; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.vpc_id
             (fun f -> Query.Pair ("VpcId", (String.to_query f)));
           Some (Query.Pair ("GroupName", (String.to_query v.group_name)));
           Some
             (Query.Pair
                ("GroupDescription", (String.to_query v.description)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Some ("group_name", (String.to_json v.group_name));
           Some ("description", (String.to_json v.description))])
    let parse xml =
      Some
        {
          description =
            (Xml.required "GroupDescription"
               (Util.option_bind (Xml.member "GroupDescription" xml)
                  String.parse));
          group_name =
            (Xml.required "GroupName"
               (Util.option_bind (Xml.member "GroupName" xml) String.parse));
          vpc_id = (Util.option_bind (Xml.member "VpcId" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "GroupDescription"
                    ([], (String.to_xml v.description)))])
             @
             [Some
                (Ezxmlm.make_tag "GroupName"
                   ([], (String.to_xml v.group_name)))])
            @
            [Util.option_map v.vpc_id
               (fun f -> Ezxmlm.make_tag "VpcId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module CreateSecurityGroupResult = CreateSecurityGroupResult
type input = CreateSecurityGroupRequest.t
type output = CreateSecurityGroupResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateSecurityGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateSecurityGroupRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateSecurityGroupRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateSecurityGroupResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateSecurityGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateSecurityGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateSecurityGroupResult - missing field in body or children: "
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