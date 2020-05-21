open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateNetworkInterfacePermissionRequest =
  struct
    type t =
      {
      network_interface_id: String.t
        [@ocaml.doc "<p>The ID of the network interface.</p>"];
      aws_account_id: String.t option
        [@ocaml.doc "<p>The AWS account ID.</p>"];
      aws_service: String.t option
        [@ocaml.doc "<p>The AWS service. Currently not supported.</p>"];
      permission: InterfacePermissionType.t
        [@ocaml.doc "<p>The type of permission to grant.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for CreateNetworkInterfacePermission.</p>"]
    let make ~network_interface_id  ?aws_account_id  ?aws_service 
      ~permission  ?dry_run  () =
      {
        network_interface_id;
        aws_account_id;
        aws_service;
        permission;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("Permission",
                  (InterfacePermissionType.to_query v.permission)));
           Util.option_map v.aws_service
             (fun f -> Query.Pair ("AwsService", (String.to_query f)));
           Util.option_map v.aws_account_id
             (fun f -> Query.Pair ("AwsAccountId", (String.to_query f)));
           Some
             (Query.Pair
                ("NetworkInterfaceId",
                  (String.to_query v.network_interface_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("permission", (InterfacePermissionType.to_json v.permission));
           Util.option_map v.aws_service
             (fun f -> ("aws_service", (String.to_json f)));
           Util.option_map v.aws_account_id
             (fun f -> ("aws_account_id", (String.to_json f)));
           Some
             ("network_interface_id",
               (String.to_json v.network_interface_id))])
    let parse xml =
      Some
        {
          network_interface_id =
            (Xml.required "NetworkInterfaceId"
               (Util.option_bind (Xml.member "NetworkInterfaceId" xml)
                  String.parse));
          aws_account_id =
            (Util.option_bind (Xml.member "AwsAccountId" xml) String.parse);
          aws_service =
            (Util.option_bind (Xml.member "AwsService" xml) String.parse);
          permission =
            (Xml.required "Permission"
               (Util.option_bind (Xml.member "Permission" xml)
                  InterfacePermissionType.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "NetworkInterfaceId"
                     ([], (String.to_xml v.network_interface_id)))])
              @
              [Util.option_map v.aws_account_id
                 (fun f ->
                    Ezxmlm.make_tag "AwsAccountId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.aws_service
                (fun f ->
                   Ezxmlm.make_tag "AwsService" ([], (String.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "Permission"
                  ([], (InterfacePermissionType.to_xml v.permission)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for CreateNetworkInterfacePermission.</p>"]
module CreateNetworkInterfacePermissionResult =
  CreateNetworkInterfacePermissionResult
type input = CreateNetworkInterfacePermissionRequest.t
type output = CreateNetworkInterfacePermissionResult.t
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
         ("Action", ["CreateNetworkInterfacePermission"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateNetworkInterfacePermissionRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateNetworkInterfacePermissionRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "CreateNetworkInterfacePermissionResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateNetworkInterfacePermissionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateNetworkInterfacePermissionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateNetworkInterfacePermissionResult - missing field in body or children: "
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