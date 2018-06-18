Clustered InfluxDB on K8S
---

I wanted to try out InfluxDB enterprise so I signed up for a trial and wrote this kubernetes config to get it up and running in a scalable, repeatable way. This is a public repo so I can get feedback from Influx or anybody who stumbles across it.

This cluster runs in a namespace called MIT (internal name of my project) but feel free to find/replace it.

Prereqs
---

You'll need an influxdb enterprise license in a secret, `influxdb`, placed in a secret in your namespace

    printf 'some-uuid-thing' | base64 | pbcopy
    kubectl -n mit create secret influxdb
    kubectl -n mit edit secret influxdb
    # put base64-encoded value under data under the key 'INFLUXDB_ENTERPRISE_LICENSE_KEY'

Turning it all on
---

You can probably get away with `kubectl create -f $THIS_REPO`.

How it works
---

Influxdb enterprise has two classes of nodes, data and meta. The meta ones are just for shard placement and a little more (I'm not the expert), the data nodes do all the work of putting data to disk and handling queries.

These kubernetes configs hinge on two statefulsets, data and meta, and creating gp2 (ssd) EBS volumes. You also need data and meta services so the nodes can discover eachother.

Telegraf
---

You may notice there's references to telegraf in this config. The aim is to monitor the influxdb enterprise nodes and ship their IO stats off to a regular influxdb instance. This is how we monitor our IO intense workloads to make sure the volumes are properly provisioned. WIP.