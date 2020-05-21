open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateVpnConnectionRouteRequest =
  struct
    type t =
      {
      destination_cidr_block: String.t
        [@ocaml.doc
          "<p>The CIDR block associated with the local subnet of the customer network.</p>"];
      vpn_connection_id: String.t
        [@ocaml.doc "<p>The ID of the VPN connection.</p>"]}[@@ocaml.doc
                                                              "<p>Contains the parameters for CreateVpnConnectionRoute.</p>"]
    let make ~destination_cidr_block  ~vpn_connection_id  () =
      { destination_cidr_block; vpn_connection_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("VpnConnectionId", (String.to_query v.vpn_connection_id)));
           Some
             (Query.Pair
                ("DestinationCidrBlock",
                  (String.to_query v.destination_cidr_block)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("vpn_connection_id", (String.to_json v.vpn_connection_id));
           Some
             ("destination_cidr_block",
               (String.to_json v.destination_cidr_block))])
    let parse xml =
      Some
        {
          destination_cidr_block =
            (Xml.required "DestinationCidrBlock"
               (Util.option_bind (Xml.member "DestinationCidrBlock" xml)
                  String.parse));
          vpn_connection_id =
            (Xml.required "VpnConnectionId"
               (Util.option_bind (Xml.member "VpnConnectionId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "DestinationCidrBlock"
                  ([], (String.to_xml v.destination_cidr_block)))])
           @
           [Some
              (Ezxmlm.make_tag "VpnConnectionId"
                 ([], (String.to_xml v.vpn_connection_id)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for CreateVpnConnectionRoute.</p>"]
module Output = Aws.BaseTypes.Unit
type input = CreateVpnConnectionRouteRequest.t
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
         ("Action", ["CreateVpnConnectionRoute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateVpnConnectionRouteRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateVpnConnectionRouteRequest.to_headers req)), "")
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