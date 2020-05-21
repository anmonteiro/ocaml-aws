open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AttachNetworkInterfaceRequest =
  struct
    type t =
      {
      device_index: Integer.t
        [@ocaml.doc
          "<p>The index of the device for the network interface attachment.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"];
      network_interface_id: String.t
        [@ocaml.doc "<p>The ID of the network interface.</p>"]}[@@ocaml.doc
                                                                 "<p>Contains the parameters for AttachNetworkInterface.</p>"]
    let make ~device_index  ?dry_run  ~instance_id  ~network_interface_id  ()
      = { device_index; dry_run; instance_id; network_interface_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("NetworkInterfaceId",
                   (String.to_query v.network_interface_id)));
           Some (Query.Pair ("InstanceId", (String.to_query v.instance_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair ("DeviceIndex", (Integer.to_query v.device_index)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("network_interface_id",
                (String.to_json v.network_interface_id));
           Some ("instance_id", (String.to_json v.instance_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("device_index", (Integer.to_json v.device_index))])
    let parse xml =
      Some
        {
          device_index =
            (Xml.required "deviceIndex"
               (Util.option_bind (Xml.member "deviceIndex" xml) Integer.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          instance_id =
            (Xml.required "instanceId"
               (Util.option_bind (Xml.member "instanceId" xml) String.parse));
          network_interface_id =
            (Xml.required "networkInterfaceId"
               (Util.option_bind (Xml.member "networkInterfaceId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "deviceIndex"
                    ([], (Integer.to_xml v.device_index)))])
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "instanceId"
                  ([], (String.to_xml v.instance_id)))])
           @
           [Some
              (Ezxmlm.make_tag "networkInterfaceId"
                 ([], (String.to_xml v.network_interface_id)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for AttachNetworkInterface.</p>"]
module AttachNetworkInterfaceResult = AttachNetworkInterfaceResult
type input = AttachNetworkInterfaceRequest.t
type output = AttachNetworkInterfaceResult.t
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
         ("Action", ["AttachNetworkInterface"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AttachNetworkInterfaceRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (AttachNetworkInterfaceRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AttachNetworkInterfaceResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp AttachNetworkInterfaceResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AttachNetworkInterfaceResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AttachNetworkInterfaceResult - missing field in body or children: "
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