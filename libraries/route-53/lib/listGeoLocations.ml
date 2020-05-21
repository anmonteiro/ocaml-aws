open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListGeoLocationsRequest =
  struct
    type t =
      {
      start_continent_code: String.t option
        [@ocaml.doc
          "<p>The code for the continent with which you want to start listing locations that Amazon Route 53 supports for geolocation. If Route 53 has already returned a page or more of results, if <code>IsTruncated</code> is true, and if <code>NextContinentCode</code> from the previous response has a value, enter that value in <code>startcontinentcode</code> to return the next page of results.</p> <p>Include <code>startcontinentcode</code> only if you want to list continents. Don't include <code>startcontinentcode</code> when you're listing countries or countries with their subdivisions.</p>"];
      start_country_code: String.t option
        [@ocaml.doc
          "<p>The code for the country with which you want to start listing locations that Amazon Route 53 supports for geolocation. If Route 53 has already returned a page or more of results, if <code>IsTruncated</code> is <code>true</code>, and if <code>NextCountryCode</code> from the previous response has a value, enter that value in <code>startcountrycode</code> to return the next page of results.</p> <p>Route 53 uses the two-letter country codes that are specified in <a href=\"https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2\">ISO standard 3166-1 alpha-2</a>.</p>"];
      start_subdivision_code: String.t option
        [@ocaml.doc
          "<p>The code for the subdivision (for example, state or province) with which you want to start listing locations that Amazon Route 53 supports for geolocation. If Route 53 has already returned a page or more of results, if <code>IsTruncated</code> is <code>true</code>, and if <code>NextSubdivisionCode</code> from the previous response has a value, enter that value in <code>startsubdivisioncode</code> to return the next page of results.</p> <p>To list subdivisions of a country, you must include both <code>startcountrycode</code> and <code>startsubdivisioncode</code>.</p>"];
      max_items: String.t option
        [@ocaml.doc
          "<p>(Optional) The maximum number of geolocations to be included in the response body for this request. If more than <code>maxitems</code> geolocations remain to be listed, then the value of the <code>IsTruncated</code> element in the response is <code>true</code>.</p>"]}
    [@@ocaml.doc
      "<p>A request to get a list of geographic locations that Amazon Route 53 supports for geolocation resource record sets. </p>"]
    let make ?start_continent_code  ?start_country_code 
      ?start_subdivision_code  ?max_items  () =
      {
        start_continent_code;
        start_country_code;
        start_subdivision_code;
        max_items
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> Query.Pair ("maxitems", (String.to_query f)));
           Util.option_map v.start_subdivision_code
             (fun f ->
                Query.Pair ("startsubdivisioncode", (String.to_query f)));
           Util.option_map v.start_country_code
             (fun f -> Query.Pair ("startcountrycode", (String.to_query f)));
           Util.option_map v.start_continent_code
             (fun f -> Query.Pair ("startcontinentcode", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> ("max_items", (String.to_json f)));
           Util.option_map v.start_subdivision_code
             (fun f -> ("start_subdivision_code", (String.to_json f)));
           Util.option_map v.start_country_code
             (fun f -> ("start_country_code", (String.to_json f)));
           Util.option_map v.start_continent_code
             (fun f -> ("start_continent_code", (String.to_json f)))])
    let parse xml =
      Some
        {
          start_continent_code =
            (Util.option_bind (Xml.member "startcontinentcode" xml)
               String.parse);
          start_country_code =
            (Util.option_bind (Xml.member "startcountrycode" xml)
               String.parse);
          start_subdivision_code =
            (Util.option_bind (Xml.member "startsubdivisioncode" xml)
               String.parse);
          max_items =
            (Util.option_bind (Xml.member "maxitems" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.start_continent_code
                 (fun f ->
                    Ezxmlm.make_tag "startcontinentcode"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.start_country_code
                (fun f ->
                   Ezxmlm.make_tag "startcountrycode" ([], (String.to_xml f)))])
            @
            [Util.option_map v.start_subdivision_code
               (fun f ->
                  Ezxmlm.make_tag "startsubdivisioncode"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_items
              (fun f -> Ezxmlm.make_tag "maxitems" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A request to get a list of geographic locations that Amazon Route 53 supports for geolocation resource record sets. </p>"]
module ListGeoLocationsResponse = ListGeoLocationsResponse
type input = ListGeoLocationsRequest.t
type output = ListGeoLocationsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/geolocations"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListGeoLocationsRequest.to_query req)))) in
  (`GET, uri, (Headers.render (ListGeoLocationsRequest.to_headers req)), "")
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
            (Failure "Could not find well formed ListGeoLocationsResponse.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListGeoLocationsResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListGeoLocationsResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListGeoLocationsResponse - missing field in body or children: "
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