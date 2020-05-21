open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyCapacityReservationRequest =
  struct
    type t =
      {
      capacity_reservation_id: String.t
        [@ocaml.doc "<p>The ID of the Capacity Reservation.</p>"];
      instance_count: Integer.t option
        [@ocaml.doc
          "<p>The number of instances for which to reserve capacity.</p>"];
      end_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time at which the Capacity Reservation expires. When a Capacity Reservation expires, the reserved capacity is released and you can no longer launch instances into it. The Capacity Reservation's state changes to <code>expired</code> when it reaches its end date and time.</p> <p>The Capacity Reservation is cancelled within an hour from the specified time. For example, if you specify 5/31/2019, 13:30:55, the Capacity Reservation is guaranteed to end between 13:30:55 and 14:30:55 on 5/31/2019.</p> <p>You must provide an <code>EndDate</code> value if <code>EndDateType</code> is <code>limited</code>. Omit <code>EndDate</code> if <code>EndDateType</code> is <code>unlimited</code>.</p>"];
      end_date_type: EndDateType.t option
        [@ocaml.doc
          "<p>Indicates the way in which the Capacity Reservation ends. A Capacity Reservation can have one of the following end types:</p> <ul> <li> <p> <code>unlimited</code> - The Capacity Reservation remains active until you explicitly cancel it. Do not provide an <code>EndDate</code> value if <code>EndDateType</code> is <code>unlimited</code>.</p> </li> <li> <p> <code>limited</code> - The Capacity Reservation expires automatically at a specified date and time. You must provide an <code>EndDate</code> value if <code>EndDateType</code> is <code>limited</code>.</p> </li> </ul>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~capacity_reservation_id  ?instance_count  ?end_date 
      ?end_date_type  ?dry_run  () =
      {
        capacity_reservation_id;
        instance_count;
        end_date;
        end_date_type;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.end_date_type
             (fun f -> Query.Pair ("EndDateType", (EndDateType.to_query f)));
           Util.option_map v.end_date
             (fun f -> Query.Pair ("EndDate", (DateTime.to_query f)));
           Util.option_map v.instance_count
             (fun f -> Query.Pair ("InstanceCount", (Integer.to_query f)));
           Some
             (Query.Pair
                ("CapacityReservationId",
                  (String.to_query v.capacity_reservation_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.end_date_type
             (fun f -> ("end_date_type", (EndDateType.to_json f)));
           Util.option_map v.end_date
             (fun f -> ("end_date", (DateTime.to_json f)));
           Util.option_map v.instance_count
             (fun f -> ("instance_count", (Integer.to_json f)));
           Some
             ("capacity_reservation_id",
               (String.to_json v.capacity_reservation_id))])
    let parse xml =
      Some
        {
          capacity_reservation_id =
            (Xml.required "CapacityReservationId"
               (Util.option_bind (Xml.member "CapacityReservationId" xml)
                  String.parse));
          instance_count =
            (Util.option_bind (Xml.member "InstanceCount" xml) Integer.parse);
          end_date =
            (Util.option_bind (Xml.member "EndDate" xml) DateTime.parse);
          end_date_type =
            (Util.option_bind (Xml.member "EndDateType" xml)
               EndDateType.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "CapacityReservationId"
                     ([], (String.to_xml v.capacity_reservation_id)))])
              @
              [Util.option_map v.instance_count
                 (fun f ->
                    Ezxmlm.make_tag "InstanceCount" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.end_date
                (fun f -> Ezxmlm.make_tag "EndDate" ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.end_date_type
               (fun f ->
                  Ezxmlm.make_tag "EndDateType" ([], (EndDateType.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module ModifyCapacityReservationResult = ModifyCapacityReservationResult
type input = ModifyCapacityReservationRequest.t
type output = ModifyCapacityReservationResult.t
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
         ("Action", ["ModifyCapacityReservation"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyCapacityReservationRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyCapacityReservationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyCapacityReservationResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyCapacityReservationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyCapacityReservationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyCapacityReservationResult - missing field in body or children: "
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