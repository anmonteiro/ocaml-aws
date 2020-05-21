open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteSecurityGroupRequest =
  struct
    type t =
      {
      group_id: String.t option
        [@ocaml.doc
          "<p>The ID of the security group. Required for a nondefault VPC.</p>"];
      group_name: String.t option
        [@ocaml.doc
          "<p>[EC2-Classic, default VPC] The name of the security group. You can specify either the security group name or the security group ID.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?group_id  ?group_name  ?dry_run  () =
      { group_id; group_name; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.group_name
             (fun f -> Query.Pair ("GroupName", (String.to_query f)));
           Util.option_map v.group_id
             (fun f -> Query.Pair ("GroupId", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.group_name
             (fun f -> ("group_name", (String.to_json f)));
           Util.option_map v.group_id
             (fun f -> ("group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          group_id =
            (Util.option_bind (Xml.member "GroupId" xml) String.parse);
          group_name =
            (Util.option_bind (Xml.member "GroupName" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.group_id
                (fun f -> Ezxmlm.make_tag "GroupId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.group_name
               (fun f -> Ezxmlm.make_tag "GroupName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteSecurityGroupRequest.t
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
         [("Version", ["2016-11-15"]); ("Action", ["DeleteSecurityGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteSecurityGroupRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteSecurityGroupRequest.to_headers req)),
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