open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateReservedInstancesListingRequest =
  struct
    type t =
      {
      client_token: String.t
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier you provide to ensure idempotency of your listings. This helps avoid duplicate listings. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">Ensuring Idempotency</a>.</p>"];
      instance_count: Integer.t
        [@ocaml.doc
          "<p>The number of instances that are a part of a Reserved Instance account to be listed in the Reserved Instance Marketplace. This number should be less than or equal to the instance count associated with the Reserved Instance ID specified in this call.</p>"];
      price_schedules: PriceScheduleSpecificationList.t
        [@ocaml.doc
          "<p>A list specifying the price of the Standard Reserved Instance for each month remaining in the Reserved Instance term.</p>"];
      reserved_instances_id: String.t
        [@ocaml.doc
          "<p>The ID of the active Standard Reserved Instance.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for CreateReservedInstancesListing.</p>"]
    let make ~client_token  ~instance_count  ~price_schedules 
      ~reserved_instances_id  () =
      { client_token; instance_count; price_schedules; reserved_instances_id
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("ReservedInstancesId",
                   (String.to_query v.reserved_instances_id)));
           Some
             (Query.Pair
                ("PriceSchedules",
                  (PriceScheduleSpecificationList.to_query v.price_schedules)));
           Some
             (Query.Pair
                ("InstanceCount", (Integer.to_query v.instance_count)));
           Some
             (Query.Pair ("ClientToken", (String.to_query v.client_token)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("reserved_instances_id",
                (String.to_json v.reserved_instances_id));
           Some
             ("price_schedules",
               (PriceScheduleSpecificationList.to_json v.price_schedules));
           Some ("instance_count", (Integer.to_json v.instance_count));
           Some ("client_token", (String.to_json v.client_token))])
    let parse xml =
      Some
        {
          client_token =
            (Xml.required "clientToken"
               (Util.option_bind (Xml.member "clientToken" xml) String.parse));
          instance_count =
            (Xml.required "instanceCount"
               (Util.option_bind (Xml.member "instanceCount" xml)
                  Integer.parse));
          price_schedules =
            (Xml.required "priceSchedules"
               (Util.option_bind (Xml.member "priceSchedules" xml)
                  PriceScheduleSpecificationList.parse));
          reserved_instances_id =
            (Xml.required "reservedInstancesId"
               (Util.option_bind (Xml.member "reservedInstancesId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "clientToken"
                    ([], (String.to_xml v.client_token)))])
             @
             [Some
                (Ezxmlm.make_tag "instanceCount"
                   ([], (Integer.to_xml v.instance_count)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "priceSchedules"
                       ([], (PriceScheduleSpecificationList.to_xml [x]))))
               v.price_schedules))
           @
           [Some
              (Ezxmlm.make_tag "reservedInstancesId"
                 ([], (String.to_xml v.reserved_instances_id)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for CreateReservedInstancesListing.</p>"]
module CreateReservedInstancesListingResult =
  CreateReservedInstancesListingResult
type input = CreateReservedInstancesListingRequest.t
type output = CreateReservedInstancesListingResult.t
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
         ("Action", ["CreateReservedInstancesListing"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateReservedInstancesListingRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateReservedInstancesListingRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateReservedInstancesListingResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateReservedInstancesListingResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateReservedInstancesListingResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateReservedInstancesListingResult - missing field in body or children: "
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