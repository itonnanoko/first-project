CREATE TABLE public.status
(
    id integer NOT NULL,
    value character varying(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT status_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.outbox_table
(
    id integer NOT NULL,
    payload jsonb NOT NULL,
    attempt integer NOT NULL,
    status_id integer NOT NULL,
    datecreated timestamp without time zone,
    dateupdated timestamp without time zone,
    CONSTRAINT outbox_table_pkey PRIMARY KEY (id),
    CONSTRAINT outbox_table_payload_key UNIQUE (payload),
    CONSTRAINT outbox_table_status_id_fkey FOREIGN KEY (status_id)
        REFERENCES public.status (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT more_five CHECK (attempt <= 5)
);


INSERT INTO public.status (id, value)
VALUES (1, 'NEW'),
(2, 'DELIVERY_FAILED'),
(3, 'DELIVERY_SUCCEED')


test for outbox_table CONSTRAINT
INSERT INTO outbox_table (id, payload, attempt, status_id)
VALUES (1,'{"name": "John","skills": [ "SQL", "C#", "Azure" ]}', 6, 2);
