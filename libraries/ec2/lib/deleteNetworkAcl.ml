open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteNetworkAclRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      network_acl_id: String.t
        [@ocaml.doc "<p>The ID of the network ACL.</p>"]}
    let make ?dry_run  ~network_acl_id  () = { dry_run; network_acl_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("NetworkAclId", (String.to_query v.network_acl_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("network_acl_id", (String.to_json v.network_acl_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          network_acl_id =
            (Xml.required "networkAclId"
               (Util.option_bind (Xml.member "networkAclId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "networkAclId"
                 ([], (String.to_xml v.network_acl_id)))])
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteNetworkAclRequest.t
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
         [("Version", ["2016-11-15"]); ("Action", ["DeleteNetworkAcl"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteNetworkAclRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteNetworkAclRequest.to_headers req)), "")
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