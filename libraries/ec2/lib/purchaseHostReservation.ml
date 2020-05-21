open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PurchaseHostReservationRequest =
  struct
    type t =
      {
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"];
      currency_code: CurrencyCodeValues.t option
        [@ocaml.doc
          "<p>The currency in which the <code>totalUpfrontPrice</code>, <code>LimitPrice</code>, and <code>totalHourlyPrice</code> amounts are specified. At this time, the only supported currency is <code>USD</code>.</p>"];
      host_id_set: RequestHostIdSet.t
        [@ocaml.doc
          "<p>The IDs of the Dedicated Hosts with which the reservation will be associated.</p>"];
      limit_price: String.t option
        [@ocaml.doc
          "<p>The specified limit is checked against the total upfront cost of the reservation (calculated as the offering's upfront cost multiplied by the host count). If the total upfront cost is greater than the specified price limit, the request fails. This is used to ensure that the purchase does not exceed the expected upfront cost of the purchase. At this time, the only supported currency is <code>USD</code>. For example, to indicate a limit price of USD 100, specify 100.00.</p>"];
      offering_id: String.t [@ocaml.doc "<p>The ID of the offering.</p>"]}
    let make ?client_token  ?currency_code  ~host_id_set  ?limit_price 
      ~offering_id  () =
      { client_token; currency_code; host_id_set; limit_price; offering_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("OfferingId", (String.to_query v.offering_id)));
           Util.option_map v.limit_price
             (fun f -> Query.Pair ("LimitPrice", (String.to_query f)));
           Some
             (Query.Pair
                ("HostIdSet", (RequestHostIdSet.to_query v.host_id_set)));
           Util.option_map v.currency_code
             (fun f ->
                Query.Pair ("CurrencyCode", (CurrencyCodeValues.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("offering_id", (String.to_json v.offering_id));
           Util.option_map v.limit_price
             (fun f -> ("limit_price", (String.to_json f)));
           Some ("host_id_set", (RequestHostIdSet.to_json v.host_id_set));
           Util.option_map v.currency_code
             (fun f -> ("currency_code", (CurrencyCodeValues.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)))])
    let parse xml =
      Some
        {
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          currency_code =
            (Util.option_bind (Xml.member "CurrencyCode" xml)
               CurrencyCodeValues.parse);
          host_id_set =
            (Xml.required "HostIdSet"
               (Util.option_bind (Xml.member "HostIdSet" xml)
                  RequestHostIdSet.parse));
          limit_price =
            (Util.option_bind (Xml.member "LimitPrice" xml) String.parse);
          offering_id =
            (Xml.required "OfferingId"
               (Util.option_bind (Xml.member "OfferingId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.client_token
                  (fun f ->
                     Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
              @
              [Util.option_map v.currency_code
                 (fun f ->
                    Ezxmlm.make_tag "CurrencyCode"
                      ([], (CurrencyCodeValues.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "HostIdSet"
                        ([], (RequestHostIdSet.to_xml [x])))) v.host_id_set))
            @
            [Util.option_map v.limit_price
               (fun f -> Ezxmlm.make_tag "LimitPrice" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "OfferingId"
                 ([], (String.to_xml v.offering_id)))])
  end
module PurchaseHostReservationResult = PurchaseHostReservationResult
type input = PurchaseHostReservationRequest.t
type output = PurchaseHostReservationResult.t
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
         ("Action", ["PurchaseHostReservation"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PurchaseHostReservationRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (PurchaseHostReservationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "PurchaseHostReservationResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp PurchaseHostReservationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed PurchaseHostReservationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PurchaseHostReservationResult - missing field in body or children: "
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