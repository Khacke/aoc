fn split_nums(nums: &str) -> (Vec<u8>, Vec<u8>) {
    let (winning, guesses) = nums.split_once('|').unwrap();

    let winning: Vec<u8> = winning
        .split_whitespace()
        .filter_map(|n| n.parse::<u8>().ok())
        .collect();
    let guesses: Vec<u8> = guesses
        .split_whitespace()
        .filter_map(|n| n.parse::<u8>().ok())
        .collect();
    (winning, guesses)
}
fn solve_part1(s: &String) -> u16 {
    let mut points = 0;
    for line in s.split('\n') {
        let mut num = 0;
        
        let (_ , nums) = line.split_once(':').unwrap();
        let (winning, guesses) = split_nums(nums);

        for guess in guesses {
            if winning.contains(&guess) {
                num += 1;
            }
        }
        if num >= 1 {   
            points += u16::pow(2, num-1)
        }
    }
    points
}
fn solve_part2(s: &String)->u32 {
    let lines: Vec<&str> = s.split('\n').collect();
    let mut wp_by_round: Vec<u32> = vec![0; lines.len()];
    for i in 0..lines.len() {
        let line = lines[i];
        let mut num: u32 = 0;

        let (_ , nums) = line.split_once(':').unwrap();
        let (winning, guesses) = split_nums(nums);

        for guess in guesses {
            if winning.contains(&guess) {
                num += 1;
            }
        }
        if num >= 1 {
            wp_by_round[i] += 1;
            for _k in 0..wp_by_round[i] {
                for j in i+1..=i+(num as usize) {
                    wp_by_round[j] += 1;
                }
            }
        } else {
            wp_by_round[i] += 1;
        }
    }
    let mut res = 0;
    for n in wp_by_round {
        res += n;
    }
    res
}
fn main() {
    let args: Vec<String> = std::env::args().collect();
    let filename = args.get(1).expect("filename was not given");

    let contents = std::fs::read_to_string(filename).expect("File is not found");

    let sol_p1 = solve_part1(&contents);
    println!("Part1 solution: {sol_p1}");

    let sol_p2 = solve_part2(&contents);
    println!("Part2 solution: {sol_p2}");
}
