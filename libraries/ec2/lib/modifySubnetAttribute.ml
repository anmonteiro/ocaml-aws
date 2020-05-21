open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifySubnetAttributeRequest =
  struct
    type t =
      {
      assign_ipv6_address_on_creation: AttributeBooleanValue.t option
        [@ocaml.doc
          "<p>Specify <code>true</code> to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. This includes a network interface that's created when launching an instance into the subnet (the instance therefore receives an IPv6 address). </p> <p>If you enable the IPv6 addressing feature for your subnet, your network interface or instance only receives an IPv6 address if it's created using version <code>2016-11-15</code> or later of the Amazon EC2 API.</p>"];
      map_public_ip_on_launch: AttributeBooleanValue.t option
        [@ocaml.doc
          "<p>Specify <code>true</code> to indicate that ENIs attached to instances created in the specified subnet should be assigned a public IPv4 address.</p>"];
      subnet_id: String.t [@ocaml.doc "<p>The ID of the subnet.</p>"]}
    let make ?assign_ipv6_address_on_creation  ?map_public_ip_on_launch 
      ~subnet_id  () =
      { assign_ipv6_address_on_creation; map_public_ip_on_launch; subnet_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("SubnetId", (String.to_query v.subnet_id)));
           Util.option_map v.map_public_ip_on_launch
             (fun f ->
                Query.Pair
                  ("MapPublicIpOnLaunch", (AttributeBooleanValue.to_query f)));
           Util.option_map v.assign_ipv6_address_on_creation
             (fun f ->
                Query.Pair
                  ("AssignIpv6AddressOnCreation",
                    (AttributeBooleanValue.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnet_id", (String.to_json v.subnet_id));
           Util.option_map v.map_public_ip_on_launch
             (fun f ->
                ("map_public_ip_on_launch",
                  (AttributeBooleanValue.to_json f)));
           Util.option_map v.assign_ipv6_address_on_creation
             (fun f ->
                ("assign_ipv6_address_on_creation",
                  (AttributeBooleanValue.to_json f)))])
    let parse xml =
      Some
        {
          assign_ipv6_address_on_creation =
            (Util.option_bind (Xml.member "AssignIpv6AddressOnCreation" xml)
               AttributeBooleanValue.parse);
          map_public_ip_on_launch =
            (Util.option_bind (Xml.member "MapPublicIpOnLaunch" xml)
               AttributeBooleanValue.parse);
          subnet_id =
            (Xml.required "subnetId"
               (Util.option_bind (Xml.member "subnetId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.assign_ipv6_address_on_creation
                (fun f ->
                   Ezxmlm.make_tag "AssignIpv6AddressOnCreation"
                     ([], (AttributeBooleanValue.to_xml f)))])
            @
            [Util.option_map v.map_public_ip_on_launch
               (fun f ->
                  Ezxmlm.make_tag "MapPublicIpOnLaunch"
                    ([], (AttributeBooleanValue.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "subnetId" ([], (String.to_xml v.subnet_id)))])
  end
module Output = Aws.BaseTypes.Unit
type input = ModifySubnetAttributeRequest.t
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
         [("Version", ["2016-11-15"]); ("Action", ["ModifySubnetAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifySubnetAttributeRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifySubnetAttributeRequest.to_headers req)), "")
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