open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DisableVgwRoutePropagationRequest =
  struct
    type t =
      {
      gateway_id: String.t
        [@ocaml.doc "<p>The ID of the virtual private gateway.</p>"];
      route_table_id: String.t
        [@ocaml.doc "<p>The ID of the route table.</p>"]}[@@ocaml.doc
                                                           "<p>Contains the parameters for DisableVgwRoutePropagation.</p>"]
    let make ~gateway_id  ~route_table_id  () =
      { gateway_id; route_table_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("RouteTableId", (String.to_query v.route_table_id)));
           Some (Query.Pair ("GatewayId", (String.to_query v.gateway_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("route_table_id", (String.to_json v.route_table_id));
           Some ("gateway_id", (String.to_json v.gateway_id))])
    let parse xml =
      Some
        {
          gateway_id =
            (Xml.required "GatewayId"
               (Util.option_bind (Xml.member "GatewayId" xml) String.parse));
          route_table_id =
            (Xml.required "RouteTableId"
               (Util.option_bind (Xml.member "RouteTableId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "GatewayId"
                  ([], (String.to_xml v.gateway_id)))])
           @
           [Some
              (Ezxmlm.make_tag "RouteTableId"
                 ([], (String.to_xml v.route_table_id)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DisableVgwRoutePropagation.</p>"]
module Output = Aws.BaseTypes.Unit
type input = DisableVgwRoutePropagationRequest.t
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
         ("Action", ["DisableVgwRoutePropagation"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DisableVgwRoutePropagationRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DisableVgwRoutePropagationRequest.to_headers req)), "")
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