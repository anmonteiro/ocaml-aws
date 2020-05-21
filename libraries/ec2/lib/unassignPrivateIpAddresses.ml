open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UnassignPrivateIpAddressesRequest =
  struct
    type t =
      {
      network_interface_id: String.t
        [@ocaml.doc "<p>The ID of the network interface.</p>"];
      private_ip_addresses: PrivateIpAddressStringList.t
        [@ocaml.doc
          "<p>The secondary private IP addresses to unassign from the network interface. You can specify this option multiple times to unassign more than one IP address.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for UnassignPrivateIpAddresses.</p>"]
    let make ~network_interface_id  ~private_ip_addresses  () =
      { network_interface_id; private_ip_addresses }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("PrivateIpAddress",
                   (PrivateIpAddressStringList.to_query
                      v.private_ip_addresses)));
           Some
             (Query.Pair
                ("NetworkInterfaceId",
                  (String.to_query v.network_interface_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("private_ip_addresses",
                (PrivateIpAddressStringList.to_json v.private_ip_addresses));
           Some
             ("network_interface_id",
               (String.to_json v.network_interface_id))])
    let parse xml =
      Some
        {
          network_interface_id =
            (Xml.required "networkInterfaceId"
               (Util.option_bind (Xml.member "networkInterfaceId" xml)
                  String.parse));
          private_ip_addresses =
            (Xml.required "privateIpAddress"
               (Util.option_bind (Xml.member "privateIpAddress" xml)
                  PrivateIpAddressStringList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "networkInterfaceId"
                  ([], (String.to_xml v.network_interface_id)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "privateIpAddress"
                      ([], (PrivateIpAddressStringList.to_xml [x]))))
              v.private_ip_addresses))
  end[@@ocaml.doc
       "<p>Contains the parameters for UnassignPrivateIpAddresses.</p>"]
module Output = Aws.BaseTypes.Unit
type input = UnassignPrivateIpAddressesRequest.t
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
         ("Action", ["UnassignPrivateIpAddresses"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (UnassignPrivateIpAddressesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (UnassignPrivateIpAddressesRequest.to_headers req)), "")
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