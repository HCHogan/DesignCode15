uniffi::include_scaffolding!("sruft");

use tokio::sync::mpsc;

pub fn rust_add(left: u64, right: u64) -> u64 {
    left + right
}

pub fn rust_greeting(text: &str) -> String {
    format!("Hello {}, this is rust", text)
}

pub fn rust_tokio_test() -> String {
    let rt = tokio::runtime::Builder::new_current_thread()
        .enable_all()
        .build()
        .unwrap();
    rt.block_on(rust_tokio_test_async())
}

async fn rust_tokio_test_async() -> String {
    let (tx, mut rx) = mpsc::channel(100);
    (0..10).for_each(|i| {
        let tx2 = tx.clone();
        tokio::spawn(async move {
            tx2.send(i).await.unwrap();
        });
    });

    let mut s = String::from("This is from tokio:");

    for _ in 0..10 {
        s.push_str(&format!("\tTask {}\n", rx.recv().await.unwrap()));
    }

    s
}
