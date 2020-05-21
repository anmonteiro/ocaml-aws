open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetGeoLocationRequest =
  struct
    type t =
      {
      continent_code: String.t option
        [@ocaml.doc
          "<p>Amazon Route 53 supports the following continent codes:</p> <ul> <li> <p> <b>AF</b>: Africa</p> </li> <li> <p> <b>AN</b>: Antarctica</p> </li> <li> <p> <b>AS</b>: Asia</p> </li> <li> <p> <b>EU</b>: Europe</p> </li> <li> <p> <b>OC</b>: Oceania</p> </li> <li> <p> <b>NA</b>: North America</p> </li> <li> <p> <b>SA</b>: South America</p> </li> </ul>"];
      country_code: String.t option
        [@ocaml.doc
          "<p>Amazon Route 53 uses the two-letter country codes that are specified in <a href=\"https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2\">ISO standard 3166-1 alpha-2</a>.</p>"];
      subdivision_code: String.t option
        [@ocaml.doc
          "<p>Amazon Route 53 uses the one- to three-letter subdivision codes that are specified in <a href=\"https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2\">ISO standard 3166-1 alpha-2</a>. Route 53 doesn't support subdivision codes for all countries. If you specify <code>subdivisioncode</code>, you must also specify <code>countrycode</code>. </p>"]}
    [@@ocaml.doc
      "<p>A request for information about whether a specified geographic location is supported for Amazon Route 53 geolocation resource record sets.</p>"]
    let make ?continent_code  ?country_code  ?subdivision_code  () =
      { continent_code; country_code; subdivision_code }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.subdivision_code
              (fun f -> Query.Pair ("subdivisioncode", (String.to_query f)));
           Util.option_map v.country_code
             (fun f -> Query.Pair ("countrycode", (String.to_query f)));
           Util.option_map v.continent_code
             (fun f -> Query.Pair ("continentcode", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.subdivision_code
              (fun f -> ("subdivision_code", (String.to_json f)));
           Util.option_map v.country_code
             (fun f -> ("country_code", (String.to_json f)));
           Util.option_map v.continent_code
             (fun f -> ("continent_code", (String.to_json f)))])
    let parse xml =
      Some
        {
          continent_code =
            (Util.option_bind (Xml.member "continentcode" xml) String.parse);
          country_code =
            (Util.option_bind (Xml.member "countrycode" xml) String.parse);
          subdivision_code =
            (Util.option_bind (Xml.member "subdivisioncode" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.continent_code
                (fun f ->
                   Ezxmlm.make_tag "continentcode" ([], (String.to_xml f)))])
            @
            [Util.option_map v.country_code
               (fun f ->
                  Ezxmlm.make_tag "countrycode" ([], (String.to_xml f)))])
           @
           [Util.option_map v.subdivision_code
              (fun f ->
                 Ezxmlm.make_tag "subdivisioncode" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A request for information about whether a specified geographic location is supported for Amazon Route 53 geolocation resource record sets.</p>"]
module GetGeoLocationResponse = GetGeoLocationResponse
type input = GetGeoLocationRequest.t
type output = GetGeoLocationResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/geolocation"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetGeoLocationRequest.to_query req)))) in
  (`GET, uri, (Headers.render (GetGeoLocationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure "Could not find well formed GetGeoLocationResponse.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetGeoLocationResponse.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed GetGeoLocationResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetGeoLocationResponse - missing field in body or children: "
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