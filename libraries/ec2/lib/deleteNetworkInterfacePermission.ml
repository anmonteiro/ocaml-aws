open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteNetworkInterfacePermissionRequest =
  struct
    type t =
      {
      network_interface_permission_id: String.t
        [@ocaml.doc "<p>The ID of the network interface permission.</p>"];
      force: Boolean.t option
        [@ocaml.doc
          "<p>Specify <code>true</code> to remove the permission even if the network interface is attached to an instance.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DeleteNetworkInterfacePermission.</p>"]
    let make ~network_interface_permission_id  ?force  ?dry_run  () =
      { network_interface_permission_id; force; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.force
             (fun f -> Query.Pair ("Force", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("NetworkInterfacePermissionId",
                  (String.to_query v.network_interface_permission_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.force (fun f -> ("force", (Boolean.to_json f)));
           Some
             ("network_interface_permission_id",
               (String.to_json v.network_interface_permission_id))])
    let parse xml =
      Some
        {
          network_interface_permission_id =
            (Xml.required "NetworkInterfacePermissionId"
               (Util.option_bind
                  (Xml.member "NetworkInterfacePermissionId" xml)
                  String.parse));
          force = (Util.option_bind (Xml.member "Force" xml) Boolean.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "NetworkInterfacePermissionId"
                   ([], (String.to_xml v.network_interface_permission_id)))])
            @
            [Util.option_map v.force
               (fun f -> Ezxmlm.make_tag "Force" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DeleteNetworkInterfacePermission.</p>"]
module DeleteNetworkInterfacePermissionResult =
  DeleteNetworkInterfacePermissionResult
type input = DeleteNetworkInterfacePermissionRequest.t
type output = DeleteNetworkInterfacePermissionResult.t
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
         ("Action", ["DeleteNetworkInterfacePermission"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DeleteNetworkInterfacePermissionRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteNetworkInterfacePermissionRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "DeleteNetworkInterfacePermissionResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DeleteNetworkInterfacePermissionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteNetworkInterfacePermissionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteNetworkInterfacePermissionResult - missing field in body or children: "
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