open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DetachNetworkInterfaceRequest =
  struct
    type t =
      {
      attachment_id: String.t [@ocaml.doc "<p>The ID of the attachment.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      force: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether to force a detachment.</p> <note> <ul> <li> <p>Use the <code>Force</code> parameter only as a last resort to detach a network interface from a failed instance. </p> </li> <li> <p>If you use the <code>Force</code> parameter to detach a network interface, you might not be able to attach a different network interface to the same index on the instance without first stopping and starting the instance.</p> </li> <li> <p>If you force the detachment of a network interface, the <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html\">instance metadata</a> might not get updated. This means that the attributes associated with the detached network interface might still be visible. The instance metadata will get updated when you stop and start the instance.</p> </li> </ul> </note>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DetachNetworkInterface.</p>"]
    let make ~attachment_id  ?dry_run  ?force  () =
      { attachment_id; dry_run; force }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.force
              (fun f -> Query.Pair ("Force", (Boolean.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair ("AttachmentId", (String.to_query v.attachment_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.force (fun f -> ("force", (Boolean.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("attachment_id", (String.to_json v.attachment_id))])
    let parse xml =
      Some
        {
          attachment_id =
            (Xml.required "attachmentId"
               (Util.option_bind (Xml.member "attachmentId" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          force = (Util.option_bind (Xml.member "force" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "attachmentId"
                   ([], (String.to_xml v.attachment_id)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.force
              (fun f -> Ezxmlm.make_tag "force" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DetachNetworkInterface.</p>"]
module Output = Aws.BaseTypes.Unit
type input = DetachNetworkInterfaceRequest.t
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
         [("Version", ["2016-11-15"]);
         ("Action", ["DetachNetworkInterface"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DetachNetworkInterfaceRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DetachNetworkInterfaceRequest.to_headers req)), "")
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