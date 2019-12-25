open Ppxlib

let loc = !Ast_helper.default_loc

let (</>) a b = Filename.concat a b
let log s = Printf.eprintf (s ^^ "\n%!")

let var_replace hostname svc_name region dns_suffix =
  let hostname = Str.replace_first (Str.regexp_string {|{region}|}) region hostname in
  let hostname = Str.replace_first (Str.regexp_string {|{service}|}) svc_name hostname in
  Str.replace_first (Str.regexp_string {|{dnsSuffix}|}) dns_suffix hostname

let write_endpoint
  svc_name
  dns_suffix
  (default_hostname : string option)
  ((region, endpoint) : (string * Endpoints_t.endpoint)) =
  let open Syntax in
  let host = match (endpoint.hostname, default_hostname) with
    | (None, None) -> [%expr None]
    | (None, Some(hostname))
    | (Some(hostname), _) ->
      [%expr Some [%e str (var_replace hostname svc_name region dns_suffix)]]
  in
  (region, host)


let write_service
  dns_suffix
  (partition_defaults : Endpoints_t.partition_defaults)
  ((svc_name, svc) : (string * Endpoints_t.service)) =
    let open Syntax in
    svc_name, (matchstrs
      [%expr region]
      (svc.endpoints |> List.map (write_endpoint svc_name dns_suffix partition_defaults.hostname))
      [%expr None])

let write_partition (p : Endpoints_t.partition) =
  let match_ = Syntax.matchstrs
        [%expr svc_name]
        (p.services |> List.map (write_service p.dns_suffix p.defaults))
        [%expr None]
  in
  [%stri let endpoint_of svc_name region = [%e match_]]

let write_url_of =
  [%stri
    let url_of svc_name region =
      match endpoint_of svc_name region with
      | Some host -> Some ("https://" ^ host)
      | None -> None
  ]

let main input outdir =
  log "Start processing endpoints";

  let inc = open_in input in
  let n = in_channel_length inc in
  let endpoint_data = really_input_string inc n in
  let endpoints = Endpoints_j.endpoints_of_string endpoint_data in
  let aws = endpoints.partitions
    |> List.find (fun p -> String.equal Endpoints_t.(p.partition) "aws") in
  let outfile = (outdir </> "endpoints.ml") in
  let syntax = write_partition aws in
  Util.Printing.write_structure outfile [syntax; write_url_of];
  close_in inc;

module CommandLine = struct
  open Cmdliner

  let input =
    let doc = "JSON file specifying AWS endpoints to generate" in
    Arg.(required & opt (some non_dir_file) None & info ["i"; "input-file"] ~docv:"Filename" ~doc)

  let outdir =
    let doc = "directory where generated library should be put" in
    Arg.(required & opt (some dir) None & info ["o"; "output-directory"] ~docv:"Directory" ~doc)

  let gen_t = Term.(pure main $ input $ outdir)

  let info =
    let doc = "Generate the endpoints mapping for AWS resources." in
    Term.info "endpoint-gen" ~version:"0.0.1" ~doc
end

(** entrypoint *)
let () =
  let open Cmdliner in
  match Term.eval CommandLine.(gen_t, info) with
  | `Error _ -> exit 1
  | _        -> exit 0
