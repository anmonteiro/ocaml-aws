open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PurchaseReservedDBInstancesOfferingMessage =
  struct
    type t =
      {
      reserved_d_b_instances_offering_id: String.t
        [@ocaml.doc
          "<p>The ID of the Reserved DB instance offering to purchase.</p> <p>Example: 438012d3-4052-4cc7-b2e3-8d3372e0e706</p>"];
      reserved_d_b_instance_id: String.t option
        [@ocaml.doc
          "<p>Customer-specified identifier to track this reservation.</p> <p>Example: myreservationID</p>"];
      d_b_instance_count: Integer.t option
        [@ocaml.doc
          "<p>The number of instances to reserve.</p> <p>Default: <code>1</code> </p>"];
      tags: TagList.t }[@@ocaml.doc "<p/>"]
    let make ~reserved_d_b_instances_offering_id  ?reserved_d_b_instance_id 
      ?d_b_instance_count  ?(tags= [])  () =
      {
        reserved_d_b_instances_offering_id;
        reserved_d_b_instance_id;
        d_b_instance_count;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.d_b_instance_count
             (fun f -> ("d_b_instance_count", (Integer.to_json f)));
           Util.option_map v.reserved_d_b_instance_id
             (fun f -> ("reserved_d_b_instance_id", (String.to_json f)));
           Some
             ("reserved_d_b_instances_offering_id",
               (String.to_json v.reserved_d_b_instances_offering_id))])
    let parse xml =
      Some
        {
          reserved_d_b_instances_offering_id =
            (Xml.required "ReservedDBInstancesOfferingId"
               (Util.option_bind
                  (Xml.member "ReservedDBInstancesOfferingId" xml)
                  String.parse));
          reserved_d_b_instance_id =
            (Util.option_bind (Xml.member "ReservedDBInstanceId" xml)
               String.parse);
          d_b_instance_count =
            (Util.option_bind (Xml.member "DBInstanceCount" xml)
               Integer.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "ReservedDBInstancesOfferingId"
                    ([],
                      (String.to_xml v.reserved_d_b_instances_offering_id)))])
             @
             [Util.option_map v.reserved_d_b_instance_id
                (fun f ->
                   Ezxmlm.make_tag "ReservedDBInstanceId"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.d_b_instance_count
               (fun f ->
                  Ezxmlm.make_tag "DBInstanceCount" ([], (Integer.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc "<p/>"]
module PurchaseReservedDBInstancesOfferingResult =
  PurchaseReservedDBInstancesOfferingResult
type input = PurchaseReservedDBInstancesOfferingMessage.t
type output = PurchaseReservedDBInstancesOfferingResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["PurchaseReservedDBInstancesOffering"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (PurchaseReservedDBInstancesOfferingMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (PurchaseReservedDBInstancesOfferingMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "PurchaseReservedDBInstancesOfferingResponse" (snd xml))
        (Xml.member "PurchaseReservedDBInstancesOfferingResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             PurchaseReservedDBInstancesOfferingResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed PurchaseReservedDBInstancesOfferingResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PurchaseReservedDBInstancesOfferingResult - missing field in body or children: "
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