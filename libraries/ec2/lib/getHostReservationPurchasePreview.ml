open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetHostReservationPurchasePreviewRequest =
  struct
    type t =
      {
      host_id_set: RequestHostIdSet.t
        [@ocaml.doc
          "<p>The IDs of the Dedicated Hosts with which the reservation is associated.</p>"];
      offering_id: String.t
        [@ocaml.doc "<p>The offering ID of the reservation.</p>"]}
    let make ~host_id_set  ~offering_id  () = { host_id_set; offering_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("OfferingId", (String.to_query v.offering_id)));
           Some
             (Query.Pair
                ("HostIdSet", (RequestHostIdSet.to_query v.host_id_set)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("offering_id", (String.to_json v.offering_id));
           Some ("host_id_set", (RequestHostIdSet.to_json v.host_id_set))])
    let parse xml =
      Some
        {
          host_id_set =
            (Xml.required "HostIdSet"
               (Util.option_bind (Xml.member "HostIdSet" xml)
                  RequestHostIdSet.parse));
          offering_id =
            (Xml.required "OfferingId"
               (Util.option_bind (Xml.member "OfferingId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "HostIdSet"
                       ([], (RequestHostIdSet.to_xml [x])))) v.host_id_set))
           @
           [Some
              (Ezxmlm.make_tag "OfferingId"
                 ([], (String.to_xml v.offering_id)))])
  end
module GetHostReservationPurchasePreviewResult =
  GetHostReservationPurchasePreviewResult
type input = GetHostReservationPurchasePreviewRequest.t
type output = GetHostReservationPurchasePreviewResult.t
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
         ("Action", ["GetHostReservationPurchasePreview"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (GetHostReservationPurchasePreviewRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (GetHostReservationPurchasePreviewRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "GetHostReservationPurchasePreviewResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             GetHostReservationPurchasePreviewResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetHostReservationPurchasePreviewResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetHostReservationPurchasePreviewResult - missing field in body or children: "
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