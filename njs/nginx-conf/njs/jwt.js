function jwt(data) {
    var parts = data.split('.').slice(0,2)
        .map(v=>Buffer.from(v, 'base64url').toString())
        .map(JSON.parse);
    return { headers:parts[0], payload: parts[1] };
}

function jwt_payload_subject(r) {
    return jwt(r.headersIn.Authorization.slice(7)).payload.sub;
}
function jwt_payload_issuer(r) {
    return jwt(r.headersIn.Authorization.slice(7)).payload.iss;
}

export default {jwt_payload_subject, jwt_payload_issuer}
