open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyReservedInstancesRequest =
  struct
    type t =
      {
      reserved_instances_ids: ReservedInstancesIdStringList.t
        [@ocaml.doc "<p>The IDs of the Reserved Instances to modify.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>A unique, case-sensitive token you provide to ensure idempotency of your modification request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">Ensuring Idempotency</a>.</p>"];
      target_configurations: ReservedInstancesConfigurationList.t
        [@ocaml.doc
          "<p>The configuration settings for the Reserved Instances to modify.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for ModifyReservedInstances.</p>"]
    let make ~reserved_instances_ids  ?client_token  ~target_configurations 
      () = { reserved_instances_ids; client_token; target_configurations }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("ReservedInstancesConfigurationSetItemType",
                   (ReservedInstancesConfigurationList.to_query
                      v.target_configurations)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Some
             (Query.Pair
                ("ReservedInstancesId",
                  (ReservedInstancesIdStringList.to_query
                     v.reserved_instances_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("target_configurations",
                (ReservedInstancesConfigurationList.to_json
                   v.target_configurations));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Some
             ("reserved_instances_ids",
               (ReservedInstancesIdStringList.to_json
                  v.reserved_instances_ids))])
    let parse xml =
      Some
        {
          reserved_instances_ids =
            (Xml.required "ReservedInstancesId"
               (Util.option_bind (Xml.member "ReservedInstancesId" xml)
                  ReservedInstancesIdStringList.parse));
          client_token =
            (Util.option_bind (Xml.member "clientToken" xml) String.parse);
          target_configurations =
            (Xml.required "ReservedInstancesConfigurationSetItemType"
               (Util.option_bind
                  (Xml.member "ReservedInstancesConfigurationSetItemType" xml)
                  ReservedInstancesConfigurationList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ReservedInstancesId"
                        ([], (ReservedInstancesIdStringList.to_xml [x]))))
                v.reserved_instances_ids))
            @
            [Util.option_map v.client_token
               (fun f ->
                  Ezxmlm.make_tag "clientToken" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag
                      "ReservedInstancesConfigurationSetItemType"
                      ([], (ReservedInstancesConfigurationList.to_xml [x]))))
              v.target_configurations))
  end[@@ocaml.doc
       "<p>Contains the parameters for ModifyReservedInstances.</p>"]
module ModifyReservedInstancesResult = ModifyReservedInstancesResult
type input = ModifyReservedInstancesRequest.t
type output = ModifyReservedInstancesResult.t
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
         ("Action", ["ModifyReservedInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyReservedInstancesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyReservedInstancesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyReservedInstancesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyReservedInstancesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyReservedInstancesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyReservedInstancesResult - missing field in body or children: "
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