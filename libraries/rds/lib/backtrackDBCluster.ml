open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module BacktrackDBClusterMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The DB cluster identifier of the DB cluster to be backtracked. This parameter is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 alphanumeric characters or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul> <p>Example: <code>my-cluster1</code> </p>"];
      backtrack_to: DateTime.t
        [@ocaml.doc
          "<p>The timestamp of the time to backtrack the DB cluster to, specified in ISO 8601 format. For more information about ISO 8601, see the <a href=\"http://en.wikipedia.org/wiki/ISO_8601\">ISO8601 Wikipedia page.</a> </p> <note> <p>If the specified time isn't a consistent time for the DB cluster, Aurora automatically chooses the nearest possible consistent time for the DB cluster.</p> </note> <p>Constraints:</p> <ul> <li> <p>Must contain a valid ISO 8601 timestamp.</p> </li> <li> <p>Can't contain a timestamp set in the future.</p> </li> </ul> <p>Example: <code>2017-07-08T18:00Z</code> </p>"];
      force: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to force the DB cluster to backtrack when binary logging is enabled. Otherwise, an error occurs when binary logging is enabled.</p>"];
      use_earliest_time_on_point_in_time_unavailable: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to backtrack the DB cluster to the earliest possible backtrack time when <i>BacktrackTo</i> is set to a timestamp earlier than the earliest backtrack time. When this parameter is disabled and <i>BacktrackTo</i> is set to a timestamp earlier than the earliest backtrack time, an error occurs.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_cluster_identifier  ~backtrack_to  ?force 
      ?use_earliest_time_on_point_in_time_unavailable  () =
      {
        d_b_cluster_identifier;
        backtrack_to;
        force;
        use_earliest_time_on_point_in_time_unavailable
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.use_earliest_time_on_point_in_time_unavailable
              (fun f ->
                 ("use_earliest_time_on_point_in_time_unavailable",
                   (Boolean.to_json f)));
           Util.option_map v.force (fun f -> ("force", (Boolean.to_json f)));
           Some ("backtrack_to", (DateTime.to_json v.backtrack_to));
           Some
             ("d_b_cluster_identifier",
               (String.to_json v.d_b_cluster_identifier))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Xml.required "DBClusterIdentifier"
               (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
                  String.parse));
          backtrack_to =
            (Xml.required "BacktrackTo"
               (Util.option_bind (Xml.member "BacktrackTo" xml)
                  DateTime.parse));
          force = (Util.option_bind (Xml.member "Force" xml) Boolean.parse);
          use_earliest_time_on_point_in_time_unavailable =
            (Util.option_bind
               (Xml.member "UseEarliestTimeOnPointInTimeUnavailable" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DBClusterIdentifier"
                    ([], (String.to_xml v.d_b_cluster_identifier)))])
             @
             [Some
                (Ezxmlm.make_tag "BacktrackTo"
                   ([], (DateTime.to_xml v.backtrack_to)))])
            @
            [Util.option_map v.force
               (fun f -> Ezxmlm.make_tag "Force" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.use_earliest_time_on_point_in_time_unavailable
              (fun f ->
                 Ezxmlm.make_tag "UseEarliestTimeOnPointInTimeUnavailable"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module DBClusterBacktrack = DBClusterBacktrack
type input = BacktrackDBClusterMessage.t
type output = DBClusterBacktrack.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["BacktrackDBCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (BacktrackDBClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (BacktrackDBClusterMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "BacktrackDBClusterResponse" (snd xml))
        (Xml.member "BacktrackDBClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DBClusterBacktrack.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DBClusterBacktrack."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBClusterBacktrack - missing field in body or children: "
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