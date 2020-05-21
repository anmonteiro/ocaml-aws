open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteRouteRequest =
  struct
    type t =
      {
      destination_cidr_block: String.t option
        [@ocaml.doc
          "<p>The IPv4 CIDR range for the route. The value you specify must match the CIDR for the route exactly.</p>"];
      destination_ipv6_cidr_block: String.t option
        [@ocaml.doc
          "<p>The IPv6 CIDR range for the route. The value you specify must match the CIDR for the route exactly.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      route_table_id: String.t
        [@ocaml.doc "<p>The ID of the route table.</p>"]}
    let make ?destination_cidr_block  ?destination_ipv6_cidr_block  ?dry_run 
      ~route_table_id  () =
      {
        destination_cidr_block;
        destination_ipv6_cidr_block;
        dry_run;
        route_table_id
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("RouteTableId", (String.to_query v.route_table_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.destination_ipv6_cidr_block
             (fun f ->
                Query.Pair ("DestinationIpv6CidrBlock", (String.to_query f)));
           Util.option_map v.destination_cidr_block
             (fun f ->
                Query.Pair ("DestinationCidrBlock", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("route_table_id", (String.to_json v.route_table_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.destination_ipv6_cidr_block
             (fun f -> ("destination_ipv6_cidr_block", (String.to_json f)));
           Util.option_map v.destination_cidr_block
             (fun f -> ("destination_cidr_block", (String.to_json f)))])
    let parse xml =
      Some
        {
          destination_cidr_block =
            (Util.option_bind (Xml.member "destinationCidrBlock" xml)
               String.parse);
          destination_ipv6_cidr_block =
            (Util.option_bind (Xml.member "destinationIpv6CidrBlock" xml)
               String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          route_table_id =
            (Xml.required "routeTableId"
               (Util.option_bind (Xml.member "routeTableId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.destination_cidr_block
                 (fun f ->
                    Ezxmlm.make_tag "destinationCidrBlock"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.destination_ipv6_cidr_block
                (fun f ->
                   Ezxmlm.make_tag "destinationIpv6CidrBlock"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "routeTableId"
                 ([], (String.to_xml v.route_table_id)))])
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteRouteRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["DeleteRoute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteRouteRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteRouteRequest.to_headers req)), "")
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