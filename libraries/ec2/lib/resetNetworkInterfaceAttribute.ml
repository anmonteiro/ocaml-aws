open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ResetNetworkInterfaceAttributeRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      network_interface_id: String.t
        [@ocaml.doc "<p>The ID of the network interface.</p>"];
      source_dest_check: String.t option
        [@ocaml.doc
          "<p>The source/destination checking attribute. Resets the value to <code>true</code>.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for ResetNetworkInterfaceAttribute.</p>"]
    let make ?dry_run  ~network_interface_id  ?source_dest_check  () =
      { dry_run; network_interface_id; source_dest_check }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.source_dest_check
              (fun f -> Query.Pair ("SourceDestCheck", (String.to_query f)));
           Some
             (Query.Pair
                ("NetworkInterfaceId",
                  (String.to_query v.network_interface_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.source_dest_check
              (fun f -> ("source_dest_check", (String.to_json f)));
           Some
             ("network_interface_id",
               (String.to_json v.network_interface_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          network_interface_id =
            (Xml.required "networkInterfaceId"
               (Util.option_bind (Xml.member "networkInterfaceId" xml)
                  String.parse));
          source_dest_check =
            (Util.option_bind (Xml.member "sourceDestCheck" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "networkInterfaceId"
                  ([], (String.to_xml v.network_interface_id)))])
           @
           [Util.option_map v.source_dest_check
              (fun f ->
                 Ezxmlm.make_tag "sourceDestCheck" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for ResetNetworkInterfaceAttribute.</p>"]
module Output = Aws.BaseTypes.Unit
type input = ResetNetworkInterfaceAttributeRequest.t
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
         ("Action", ["ResetNetworkInterfaceAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ResetNetworkInterfaceAttributeRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ResetNetworkInterfaceAttributeRequest.to_headers req)),
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